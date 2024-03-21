import 'package:flutter/material.dart';
import 'package:store_app/screens/HomeStore.dart';
import 'package:store_app/screens/Home_Login.dart';
import 'package:store_app/screens/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      title: "Kindacode.com",
      home: SplashScreen(),
    );
  }
}
