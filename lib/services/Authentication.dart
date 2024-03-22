import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:store_app/constants/API_URLS.dart';
import 'package:store_app/services/CsrfToken.dart';

class LoginService {
  static final Uri uri = Uri.parse(ApiUrls.WebSocketUrl);
  static WebSocketChannel? _channel;

  static WebSocketChannel get channel {
    if (_channel == null) {
      _channel = IOWebSocketChannel.connect(uri);
    }
    return _channel!;
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    Csrf csrf = Csrf();
    Dio dio = Dio();

    // Get CSRF token
    String? csrfToken = await csrf.getCsrfToken();

    // Define headers with CSRF token
    var headers = {
      'X-CSRFToken': csrfToken,
      'Cookie': 'csrftoken=$csrfToken',
    };

    var data = {
      'action': 'login',
      'email': email,
      'password': password,
      'csrf_token': csrfToken,
    };

    try {
      // Establish WebSocket connection
      if (_channel != null) {
        _channel!.sink.close();
        _channel = null;
      }

      // Establish a new WebSocket connection
      _channel = IOWebSocketChannel.connect(uri);
      channel.sink.add(jsonEncode(data));

      // Create a Completer to handle the response asynchronously
      Completer<Map<String, dynamic>> completer = Completer();

      // Listen for messages from WebSocket
      _channel!.stream.listen((event) {
        // Parse JSON message
        var jsonData = jsonDecode(event);
        completer.complete(jsonData);
      }, onError: (error) {
        print("Error occurred: $error");
        completer.completeError({'success': false, 'message': 'Login failed'});
      });

      // Return the received data asynchronously
      return completer.future;
    } catch (error) {
      print("Error occurred: $error");
      return {'success': false, 'message': 'Login failed'};
    }
  }
}

class RegisterService {
  static final Uri uri = Uri.parse(ApiUrls.WebSocketUrl);
  static WebSocketChannel? _channel;

  static WebSocketChannel get channel {
    if (_channel == null) {
      _channel = IOWebSocketChannel.connect(uri);
    }
    return _channel!;
  }

  Future<Map<String, dynamic>> registerUser(
      String username, String email, String password) async {
    Csrf csrf = Csrf();
    Dio dio = Dio();

    // Get CSRF token
    String? csrfToken = await csrf.getCsrfToken();

    // Define headers with CSRF token
    var headers = {
      'X-CSRFToken': csrfToken,
      'Cookie': 'csrftoken=$csrfToken',
    };

    var data = {
      'action': 'register',
      'username': username,
      'email': email,
      'password': password,
      'csrf_token': csrfToken,
    };

    try {
      // Close the WebSocket channel if it's open
      if (_channel != null) {
        _channel!.sink.close();
        _channel = null;
      }

      // Establish a new WebSocket connection
      _channel = IOWebSocketChannel.connect(uri);
      channel.sink.add(jsonEncode(data));

      // Create a Completer to handle the response asynchronously
      Completer<Map<String, dynamic>> completer = Completer();

      // Listen for messages from WebSocket
      _channel!.stream.listen((event) {
        // Parse JSON message
        var jsonData = jsonDecode(event);
        completer.complete(jsonData);
      }, onError: (error) {
        print("Error occurred: $error");
        completer.completeError(
            {'success': false, 'message': 'Registration failed'});
      });

      // Return the received data asynchronously
      return completer.future;
    } catch (error) {
      print("Error occurred: $error");
      return {'success': false, 'message': 'Registration failed'};
    }
  }
}



// import 'dart:async';
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:web_socket_channel/web_socket_channel.dart'; // Correct import
// import 'package:web_socket_channel/io.dart';
// import 'package:store_app/constants/API_URLS.dart';
// import 'package:store_app/services/CsrfToken.dart';

// class LoginService {
//   static Uri uri = Uri.parse(ApiUrls.WebSocketUrl);

//   static WebSocketChannel channel = IOWebSocketChannel.connect(uri);

//   Future<Map<String, dynamic>> loginUser(String email, String password) async {
//     Csrf csrf = Csrf();
//     Dio dio = Dio();

//     // Get CSRF token
//     String? csrfToken = await csrf.getCsrfToken();

//     // Define headers with CSRF token
//     var headers = {
//       'X-CSRFToken': csrfToken,
//       'Cookie': 'csrftoken=$csrfToken',
//     };

//     var data = {
//       'action': 'login',
//       'email': email,
//       'password': password,
//       'csrf_token': csrfToken,
//     };

//     try {
//       // Make the POST request with headers
//       var response = await dio.post(ApiUrls.loginUrl,
//           data: FormData.fromMap(data), options: Options(headers: headers));
//       print(response.data);

//       // Establish WebSocket connection
//       await establishWebSocket();

//       // Return the JSON response
//       return jsonDecode(response.data);
//     } catch (e) {
//       print("Error occurred: $e");
//       return {'success': false, 'message': 'Login failed'};
//     }
//   }

//   Future<void> establishWebSocket() async {
//     var uri = Uri.parse('ws://192.168.1.9:8080/ws/socket-server/');
//     WebSocketChannel channel = IOWebSocketChannel.connect(uri);

//     channel.stream.listen((event) {
//       print(event); // Handle incoming messages from the websocket
//     });

//     // Sending a message to the server
//     channel.sink.add(jsonEncode({'message': 'Hello WebSocket server!'}));

//     // Close the WebSocket connection when done
//     // channel.sink.close();
//   }
// }



// class RegisterService {
//   static Uri uri = Uri.parse(ApiUrls.WebSocketUrl);
//   static WebSocketChannel? _channel;

//   static WebSocketChannel get channel {
//     if (_channel == null) {
//       _channel = IOWebSocketChannel.connect(uri);
//     }
//     return _channel!;
//   }

//   Future<Map<String, dynamic>> registerUser(
//       String username, String email, String password) async {
//     Csrf csrf = Csrf();
//     Dio dio = Dio();

//     // Get CSRF token
//     String? csrfToken = await csrf.getCsrfToken();

//     // Define headers with CSRF token
//     var headers = {
//       'X-CSRFToken': csrfToken,
//       'Cookie': 'csrftoken=$csrfToken',
//     };

//     var data = {
//       'action': 'register',
//       'username': username,
//       'email': email,
//       'password': password,
//       'csrf_token': csrfToken,
//     };

//     try {
//       // Close the WebSocket channel if it's open
//       if (_channel != null) {
//         _channel!.sink.close();
//         _channel = null;
//       }

//       // Establish a new WebSocket connection
//       _channel = IOWebSocketChannel.connect(uri);
//       channel.sink.add(jsonEncode(data));

//       _channel!.stream.listen((event) {
//         Completer<Map<String, dynamic>> completer = Completer();
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         print(jsonDecode(event));
//         return jsonDecode(event);
//       });
//     } catch (error) {
//       print(error);
//       return {"error": "error"};
//     }
//     return {"error": "error"};
//   }
// }
