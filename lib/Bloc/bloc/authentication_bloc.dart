import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/services/Authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      emit(AuthenticationInitial());
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String token = sharedPreferences.getString("token").toString();
      if (event is AuthenticationRegistering) {
        await register(event, emit);
      } else if (event is AuthenticationLoggingIn) {
        await Login(event, emit); // Await the asynchronous operation
      }
    });
  }
  String? loginErrorMessage;
  Future<void> register(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    log(emit.toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token").toString();

    if (event is AuthenticationRegistering) {
      var data = await RegisterService()
          .registerUser(event.username, event.email, event.password);
      log(data["error"].toString());
      if (data["error"].toString().contains("already exists") ||
          data["error"].toString() != 'null') {
        loginErrorMessage = data["error"].toString();
        emit(RegisterFailed());
      } else if (data["data"].toString().contains('Success') == true) {
        emit(RegisterSuccess());
      }
    } else if (event is AuthenticationEvent && token == 'null') {
      emit(RegisterInitial());
    }
  }

  Future<void> Login(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    log("i am here 11111111111111111");

    log(emit.toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token").toString();
    if (event is AuthenticationLoggingIn) {
      Map<String, dynamic> data =
          await LoginService().loginUser(event.email, event.password);
      if (data["token"].toString() != 'null' &&
          data.containsKey('error') == false) {
        sharedPreferences.setString('token', data["token"].toString());
        emit(LoginSuccess());
      } else {
        log("i am here 22");

        loginErrorMessage = data['error'];
        emit(LoginFailed());
      }
    } else if (event is AuthenticationEvent && token == 'null') {
      log("i am here 44");

      emit(LoginInitial());
    }
  }
}
