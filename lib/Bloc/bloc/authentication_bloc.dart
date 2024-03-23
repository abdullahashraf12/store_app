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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token").toString();
    if (event is AuthenticationLoggingIn) {
      Map<String, dynamic> data =
          await LoginService().loginUser(event.email, event.password);
      log(data["token"]);
      sharedPreferences.setString('token', data["token"]);
      token = sharedPreferences.getString("token").toString();

      log("token is " + token);

      if (data.containsKey('error')) {
        log(data['error']);
        loginErrorMessage = data['error'];
        log("i am here 22");

        emit(LoginFailed());
      } else if (data.containsKey('token') && data['token'] != null) {
        sharedPreferences.setString("token", data['token'].toString());
        log("i am here 33");
        emit(LoginSuccess());
      }
    } else if (event is AuthenticationEvent && token == 'null') {
      log("i am here 44");

      emit(LoginInitial());
    }
  }
}
