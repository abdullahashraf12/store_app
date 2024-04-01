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
