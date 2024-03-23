import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Bloc/bloc/authentication_bloc.dart';
import 'package:store_app/screens/HomeScreen.dart';
import 'package:store_app/screens/Register.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late String errorMessage; // Declare but do not initialize errorMessage here

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is LoginSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    }, builder: (context, state) {
      log(state.toString());
      return Center(
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  state is LoginFailed
                      ? // Show error message if exists
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Error: ${BlocProvider.of<AuthenticationBloc>(context).loginErrorMessage}',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(),
                        ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        // Perform login action here
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        print('Email: $email');
                        print('Password: $password');
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticationLoggingIn(
                              email: email, password: password),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (builder) {
                        return RegisterPage();
                      }));
                    },
                    child: Text(
                      'Already have an account? Login here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
