import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:store_app/services/WebSocketNotification.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class BackgroundService {
  static void onStart(ServiceInstance service) {
    DartPluginRegistrant.ensureInitialized();

    service.on("setAsForeground").listen((event) {
      print("foreground ===============");
    });

    service.on("setAsBackground").listen((event) async {
      WebSocketNotificationService ser = WebSocketNotificationService();
      while (true) {
        try {
          await ser.connect();
        } catch (error) {
          print("error");
        }
      }
    });

    service.on("stopService").listen((event) {
      service.stopSelf();
    });
  }

  FlutterLocalNotificationsPlugin flutterLocalPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel notificationChannel = AndroidNotificationChannel(
      "coding", "coding is life foreground service",
      description: "This is channel des....", importance: Importance.high);

  Future<void> configureService() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _configureAndroidService();
    await _configureIOSService();
  }

  @pragma("vm:enry-point")
  Future<bool> Background(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    return true;
  }

  Future<void> _configureAndroidService() async {
    var service = FlutterBackgroundService();

    await flutterLocalPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(notificationChannel);

    // Service initialization and configuration
    await service.configure(
      iosConfiguration: IosConfiguration(
        onBackground: Background,
        onForeground: onStart,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: false,
        foregroundServiceNotificationId: 90,
      ),
    );
  }

  Future<void> _configureIOSService() async {
    if (Platform.isIOS) {
      await flutterLocalPlugin.initialize(
          const InitializationSettings(iOS: DarwinInitializationSettings()));
    }
  }

  Future<void> initializeNotifications() async {
    await configureService();
    FlutterBackgroundService().startService();
    FlutterBackgroundService().invoke("setAsBackground");
  }
}
