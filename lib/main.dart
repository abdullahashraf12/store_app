// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:store_app/Bloc/bloc/authentication_bloc.dart';
import 'package:store_app/screens/SplashScreen.dart';

// final FlutterLocalNotificationsPlugin flutterLocalPlugin =
//     FlutterLocalNotificationsPlugin();
// const AndroidNotificationChannel notificationChannel =
//     AndroidNotificationChannel(
//         "coding is life", "codeing is life foreground service",
//         description: "this is channel Description",
//         importance: Importance.high);
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await initservice();
  runApp(MyApp());
  // FlutterBackgroundService().startService();
}

// @pragma("vm:entry-point")
// void onStart(ServiceInstance service) {
//   DartPluginRegistrant.ensureInitialized();
//   service.on("setAsForeground").listen((event) {
//     print("Foreground");
//   });

//   service.on("setAsBackground").listen((event) {
//     service.stopSelf();
//   });

//   service.on("StopService").listen((event) {
//     print("Background");
//   });
// }

// @pragma("vm:entry-point")
// Future<bool> iosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   return true;
// }

// Future<void> initservice() async {
//   var service = FlutterBackgroundService();
//   if (Platform.isIOS) {
//     await flutterLocalPlugin.initialize(
//         const InitializationSettings(iOS: DarwinInitializationSettings()));
//   }
//   await flutterLocalPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(notificationChannel);
//   await service.configure(
//       iosConfiguration:
//           IosConfiguration(onBackground: iosBackground, onForeground: onStart),
//       androidConfiguration: AndroidConfiguration(
//           onStart: onStart,
//           autoStart: true,
//           isForegroundMode: true,
//           notificationChannelId: "coding is life",
//           initialNotificationTitle: "coding is life",
//           foregroundServiceNotificationId: 90));
//   service.startService();
// }

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return AuthenticationBloc();
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.amber),
        title: "Kindacode.com",
        home: SplashScreen(),
      ),
      // Remove the debug banner
    );
  }
}
