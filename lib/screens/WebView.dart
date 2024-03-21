import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHomeWidget extends StatelessWidget {
  WebViewHomeWidget({super.key});
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // print the loading progress to the console
          // you can use this value to show a progress bar if you want
          debugPrint("Loading: $progress%");
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse("http://192.168.1.11:8080"));
  TextEditingController txc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _controller.loadRequest(Uri.parse("http://192.168.1.11:8080"));
              },
              child: const Text("Search"),
            ),
          ),
        ],
      ),
    );
  }
}
