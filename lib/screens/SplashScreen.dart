import 'package:flutter/material.dart';
import 'package:store_app/screens/Home_Login.dart';

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
    Future.delayed(Duration(milliseconds: 3000)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) {
        return const LoginPage();
      }));
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
