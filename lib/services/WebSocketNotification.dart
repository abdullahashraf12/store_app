import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/constants/API_URLS.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class WebSocketNotificationService {
  IOWebSocketChannel? _channel;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> connect() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token") ?? '';
    if (token.isEmpty) {
      log('Token is empty. Cannot connect to WebSocket.');
      return;
    }

    try {
      _channel = IOWebSocketChannel.connect(
          '${ApiUrls.WebSocketNotificationUrl}/$token');
      print('${ApiUrls.WebSocketNotificationUrl}/$token');
      print('${ApiUrls.WebSocketNotificationUrl}/$token');
      print('${ApiUrls.WebSocketNotificationUrl}/$token');
      print('${ApiUrls.WebSocketNotificationUrl}/$token');
      print('${ApiUrls.WebSocketNotificationUrl}/$token');
      print('${ApiUrls.WebSocketNotificationUrl}/$token');
      print('${ApiUrls.WebSocketNotificationUrl}/$token');

      _channel!.stream.listen(
        (message) {
          var decodedMessage = null;
          try {
            print('Type of message: ${message.runtimeType}');
            // Decode the JSON message
            decodedMessage = jsonDecode(message.toString());

            // Log the decoded message
            log('Received message: $decodedMessage');
            if (decodedMessage is! List) {
              throw FormatException('Invalid message format. Expected a list.');
            }
            for (var notification in decodedMessage) {
              // Extract the notification message from the notification object
              String notificationMessage = notification['message'];
              int id = notification['id'];
              log("My Id " +
                  id.toString() +
                  "My Message" +
                  notificationMessage.toString());
              // Show the notification
              // showNotification(id, notificationMessage); // You can implement this method if needed
            }
          } catch (e) {
            log('Error decoding or processing message: $e');
          }
        },
        onError: (error) {
          log('WebSocket error: $error');
          // Handle error here
        },
        onDone: () {
          log('WebSocket closed.');
          // Handle closure here, maybe attempt reconnection?
        },
      );
    } catch (e) {
      log('Error connecting to WebSocket: $e');
      // Handle connection error here
    }
  }

  Future<void> disconnect() async {
    _channel?.sink.close();
  }

  Future<void> showNotification(int id, String message) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'ChannelID',
      'ChannelName',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/ic_launcher', // Full path to the icon
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      id,
      'New Message',
      message,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
















// import 'dart:async';
// import 'dart:convert'; // Import for JSON decoding
// import 'dart:developer';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:store_app/constants/API_URLS.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class WebSocketNotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> connect() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String token = sharedPreferences.getString("token") ?? '';
//     if (token.isEmpty) {
//       log('Token is empty. Cannot connect to WebSocket.');
//       return;
//     }

//     while (true) {
//       try {
//         final channel = IOWebSocketChannel.connect(
//             '${ApiUrls.WebSocketNotificationUrl}/${token}');

//         channel.stream.listen(
//           (message) {
//             try {
//               // Decode the JSON message
//               var decodedMessage = jsonDecode(message);

//               // Log the decoded message
//               log('Received message: $decodedMessage');
//               if (decodedMessage is! List) {
//                 throw FormatException(
//                     'Invalid message format. Expected a list.');
//               }
//               for (var notification in decodedMessage) {
//                 // Extract the notification message from the notification object
//                 String notificationMessage = notification['message'];
//                 int id = notification['id'];
//                 log("My Id" +
//                     id.toString() +
//                     "My Message" +
//                     notificationMessage.toString());
//                 // Show the notification
//                 showNotification(id, notificationMessage);
//               }
//             } catch (e) {
//               log('Error decoding or processing message: $e');
//             }
//           },
//           onError: (error) {
//             log('WebSocket error: $error');
//             // Handle error here
//           },
//           onDone: () {
//             log('WebSocket closed.');
//             // Handle closure here
//           },
//         );

//         // Wait for a while before reconnecting
//         await Future.delayed(Duration(seconds: 10));
//       } catch (e) {
//         log('Error connecting to WebSocket: $e');
//         // Handle connection error here
//       }
//     }
//   }

//   Future<void> showNotification(int id, String message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'ChannelID',
//       'ChannelName',
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@drawable/ic_launcher', // Full path to the icon
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       id,
//       'New Message',
//       message,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }
// }
