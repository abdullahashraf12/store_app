// import 'package:flutter/material.dart';
// import 'package:store_app/screens/HomeScreen.dart';
// import 'package:store_app/screens/Register.dart';
// import 'package:store_app/services/Authentication.dart';

// class LoginWidget extends StatefulWidget {
//   LoginWidget({Key? key}) : super(key: key);

//   @override
//   _LoginWidgetState createState() => _LoginWidgetState();
// }

// class _LoginWidgetState extends State<LoginWidget> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   String? _errorMessage;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Scaffold(
//         body: Form(
//           key: _formKey,
//           child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 if (_errorMessage != null) // Show error message if exists
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Text(
//                       _errorMessage!,
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     prefixIcon: Icon(Icons.email),
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20.0),
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     prefixIcon: Icon(Icons.lock),
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState != null &&
//                         _formKey.currentState!.validate()) {
//                       // Perform login action here
//                       String email = _emailController.text;
//                       String password = _passwordController.text;
//                       print('Email: $email');
//                       print('Password: $password');
//                       Map<String, dynamic> data =
//                           await LoginService().loginUser(email, password);

//                       if (data["error"].toString().isEmpty == false) {
//                         setState(() {
//                           _errorMessage = data['error'];
//                         });
//                       } else if (data["token"].toString().isEmpty == false) {
//                         // Navigate to home view
//                         Navigator.pushReplacement(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const HomeScreen();
//                         }));
//                       }
//                     }
//                   },
//                   child: Text('Submit'),
//                 ),
//                 SizedBox(height: 20.0),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (builder) {
//                       return RegisterPage();
//                     }));
//                   },
//                   child: Text(
//                     'Already have an account? Login here',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.blue,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_app/screens/HomeScreen.dart';
import 'package:store_app/screens/Register.dart';
import 'package:store_app/services/Authentication.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
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
                if (_errorMessage != null) // Show error message if exists
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Error: $_errorMessage',
                      style: TextStyle(color: Colors.red),
                    ),
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
                      Map<String, dynamic> data =
                          await LoginService().loginUser(email, password);
                      print(data);
                      print(data);
                      print(data);
                      print(data);
                      print(data);
                      print(data);
                      print(data);
                      print(data);
                      print(data);
                      print(data);
                      if (data.containsKey('error')) {
                        setState(() {
                          _errorMessage = data['error'].toString();
                        });
                      } else if (data.containsKey('token') &&
                          data['token'] != null) {
                        // Navigate to home view
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const HomeScreen();
                        }));
                      }
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
  }
}
