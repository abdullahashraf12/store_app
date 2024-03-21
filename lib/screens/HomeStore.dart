import 'package:store_app/widgets/HomeWebWidget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({
    super.key,
  });

  // Create a webview controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewHome());
  }
}
