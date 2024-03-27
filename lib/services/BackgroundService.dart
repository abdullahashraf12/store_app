import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/services/WebSocketNotification.dart';

class BackgroundService {
  @pragma("vm:entry-point")
  static void onStart(ServiceInstance service) async {
    service.on("setAsForeground").listen((event) {
      print("Foreground Mode");
    });

    service.on("setAsBackground").listen((event) async {});

    service.on("stopService").listen((event) async {
      WebSocketNotificationService seree = WebSocketNotificationService();
      while (true) {
        try {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          String token = sharedPreferences.getString("token") ?? '';
          if (token.isEmpty == false) {
            if (seree.isConnected == false) {
              print("seree.isConnected default : ${seree.isConnected}");

              await seree.connect();

              print("seree.isConnected Non default : ${seree.isConnected}");
            }
          }
          await Future.delayed(const Duration(seconds: 3));

          print("i am here here");
        } catch (error) {}
      }
    });

    WebSocketNotificationService seree = WebSocketNotificationService();
    while (true) {
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        String token = sharedPreferences.getString("token") ?? '';
        if (token.isEmpty == false) {
          if (seree.isConnected == false) {
            print("seree.isConnected default : ${seree.isConnected}");

            await seree.connect();

            print("seree.isConnected Non default : ${seree.isConnected}");
          }
        }
        await Future.delayed(const Duration(seconds: 3));

        print("i am here here");
      } catch (error) {}
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel notificationChannel =
      const AndroidNotificationChannel(
    "coding",
    "coding is life foreground service",
    description: "This is channel description",
    importance: Importance.max,
  );

  Future<void> configureService() async {
    WidgetsFlutterBinding.ensureInitialized();
    await configureAndroidService();
    await configureIOSService();
  }

  @pragma("vm:enry-point")
  Future<bool> Background(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    return true;
  }

  Future<void> configureAndroidService() async {
    var service = FlutterBackgroundService();

    await flutterLocalPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(notificationChannel);

    // Service initialization and configuration
    await service.configure(
      iosConfiguration: IosConfiguration(
        onBackground: Background,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: false,
        foregroundServiceNotificationId: 90,
      ),
    );
  }

  Future<void> configureIOSService() async {
    if (Platform.isIOS) {
      await flutterLocalPlugin.initialize(
        const InitializationSettings(iOS: DarwinInitializationSettings()),
      );
    }
  }

  Future<void> initializeNotifications() async {
    await configureService();
    FlutterBackgroundService().startService();
    // FlutterBackgroundService().invoke("setAsBackground");
  }
}
