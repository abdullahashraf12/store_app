import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/screens/HomeScreen.dart';
import 'package:store_app/screens/Home_Login.dart';
import 'package:store_app/screens/Register.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token;
      token = prefs.getString("token");
      log(token.toString());

      log(token.toString().isEmpty.toString());
      if (token.toString() == 'null') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) {
          // return LoginPage();
          log("i am here 222222");

          return LoginPage();

          // return LoginPage();
          // return RegisterPage();
        }));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) {
          log("i am here 44567");
          log(token.toString());
          return HomeScreen();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Splash.png", width: 200, height: 200),
            Image.asset("assets/images/loading.gif", width: 250, height: 250)
          ],
        ),
      ),
    );
  }
}
