import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/Bloc/bloc/authentication_bloc.dart';
import 'package:store_app/screens/SplashScreen.dart';
import 'package:store_app/services/BackgroundService.dart';

// const String taskName = "background_task"; // Unique task name

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     try {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       String token = sharedPreferences.getString("token") ?? '';
//       if (token.isNotEmpty) {
//         WebSocketNotificationService service = WebSocketNotificationService();
//         await service.connect();
//         print("WebSocket connection established in background task.");
//       } else {
//         print("Token not found or empty.");
//       }
//     } catch (error) {
//       print("Error connecting to WebSocket: $error");
//     }
//     return Future.value(true);
//   });
// }

void main() async {
  try {
    await BackgroundService().initializeNotifications();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token") ?? '';
    if (token.isNotEmpty) {
      await BackgroundService().initializeNotifications();
    }
  } catch (error) {}
  // WidgetsFlutterBinding.ensureInitialized();
  // await Workmanager().initialize(callbackDispatcher);
  // await Workmanager().registerPeriodicTask(1
  //   taskName,
  //   "background_task",
  //   initialDelay: const Duration(seconds: 10),
  //   frequency: const Duration(minutes: 1), // Adjust frequency as needed
  //   constraints: Constraints(networkType: NetworkType.connected),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.amber),
        title: "Kindacode.com",
        home: const SplashScreen(),
      ),
    );
  }
}
