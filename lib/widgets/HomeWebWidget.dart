import 'package:flutter/material.dart';
import 'package:store_app/screens/WebView.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHome extends StatelessWidget {
  WebViewHome({super.key});
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _controller
                        .loadRequest(Uri.parse("http://192.168.1.11:8080"));
                  },
                  child: const Text("Home"),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: txc,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 1.0),
                      ),
                      suffixIcon: const Icon(
                          Icons.search), // Moves the search icon to the right
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _controller
                        .loadRequest(Uri.parse("http://192.168.1.11:8080"));
                  },
                  child: const Text("Search"),
                ),
              ),
            ],
          ),
          Expanded(child: WebViewHomeWidget()),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment
          //       .spaceBetween, // Ensures equal space between buttons
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 25.0),
          //       child: ElevatedButton(
          //         onPressed: () {
          //           _controller.loadRequest(Uri.parse(
          //               "http://192.168.1.11:8080/userauths/sign-up"));
          //         },
          //         child: const Text("Sign Up"),
          //       ),
          //     ),
          //     const SizedBox(
          //         width: 16), // Adds space between first and second button
          //     ElevatedButton(
          //       onPressed: () {
          //         _controller.loadRequest(
          //             Uri.parse("http://192.168.1.11:8080/userauths/sign-out"));
          //       },
          //       child: const Text("Sign Out"),
          //     ),
          //     const SizedBox(
          //         width: 16), // Adds space between second and third button
          //     Padding(
          //       padding: const EdgeInsets.only(right: 25.0),
          //       child: ElevatedButton(
          //         onPressed: () {
          //           _controller.loadRequest(Uri.parse(
          //               "http://192.168.1.11:8080/userauths/sign-in"));
          //         },
          //         child: const Text("Sign In"),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
