import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/screens/HomeScreen.dart';
import 'package:store_app/screens/Home_Login.dart';
import 'package:store_app/services/BackgroundService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> initializeApp() async {
    BackgroundService bs = BackgroundService();
    await bs.initializeNotifications();
  }

  @override
  void initState() {
    super.initState();
    log("Splash Screen");
    Future.delayed(const Duration(milliseconds: 3000)).then((value) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String token = sharedPreferences.getString("token").toString();
      if (token != "null") {
        // Listen for the message indicating background setup completion
        FlutterBackgroundService()
            .on("setAsBackgroundComplete")
            .listen((event) {
          if (event == "setAsBackgroundComplete") {
            // Set the service as background after WebSocket connection is established
            FlutterBackgroundService().invoke("setAsBackground");
          }
        });

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
