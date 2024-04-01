import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/Bloc/bloc/authentication_bloc.dart';
import 'package:store_app/screens/SplashScreen.dart';
import 'package:store_app/services/BackgroundService.dart';

void main() async {
  try {
    await BackgroundService().initializeNotifications();
  } catch (error) {}

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
