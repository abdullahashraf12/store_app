import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Bloc/bloc/authentication_bloc.dart';
import 'package:store_app/screens/Home_Login.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is RegisterSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => (const LoginPage())),
        );
      }
    }, builder: (context, state) {
      log(state.toString());
      return Center(
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  state is RegisterFailed
                      ? // Show error message if exists
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Error: ${BlocProvider.of<AuthenticationBloc>(context).loginErrorMessage}',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 10),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(),
                        ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
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
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  state is AuthenticationLoading
                      ? Image.asset("assets/images/loading.gif",
                          width: 250, height: 250)
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              // You can handle registration logic here
                              String username = _usernameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                AuthenticationRegistering(
                                    username: username,
                                    email: email,
                                    password: password),
                              );
                              // _registerUser(username, email, password);
                              // initState() {}
                            }
                          },
                          child: const Text('Register'),
                        ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (builder) {
                        return const LoginPage();
                      }));
                    },
                    child: const Text(
                      'Already have an account? Login here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
