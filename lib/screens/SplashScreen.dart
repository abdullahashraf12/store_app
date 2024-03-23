import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/Bloc/bloc/authentication_bloc.dart';
import 'package:store_app/screens/HomeScreen.dart';
import 'package:store_app/screens/Home_Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    log("Splash Screen");
    Future.delayed(const Duration(milliseconds: 3000)).then((value) async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Splash.png", width: 200, height: 200),
            Image.asset("assets/images/loading.gif", width: 250, height: 250)
          ],
        ),
      ),
    );
  }
}




// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:store_app/Bloc/bloc/authentication_bloc.dart';
// import 'package:store_app/screens/HomeScreen.dart';
// import 'package:store_app/screens/Home_Login.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(const Duration(milliseconds: 3000)).then((value) async {
//       SharedPreferences shPref = await SharedPreferences.getInstance();

//       BlocConsumer<AuthenticationBloc, AuthenticationState>(
//           builder: (context, state) {
//         return const SplashScreen();
//       }, listener: (context, state) {
//         if (state is LoginSuccess && shPref.get('token') == 'null') {
//           Navigator.pushReplacement(context, MaterialPageRoute(
//             builder: (context) {
//               return const LoginPage(errorMessage: '');
//             },
//           ));
//         } else if (state is LoginFailed) {
//           // return const LoginPage(errorMessage: 'Authentication Failed');
//           Navigator.pushReplacement(context, MaterialPageRoute(
//             builder: (context) {
//               return const LoginPage(errorMessage: 'Authentication Failed');
//             },
//           ));
//         } else if (shPref.get('token').toString() != 'null') {
//           Navigator.pushReplacement(context, MaterialPageRoute(
//             builder: (context) {
//               return const HomeScreen();
//             },
//           ));
//           // return HomeScreen();
//         }
//         // return const LoginPage(errorMessage: '');
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset("assets/images/Splash.png", width: 200, height: 200),
//             Image.asset("assets/images/loading.gif", width: 250, height: 250)
//           ],
//         ),
//       ),
//     );
//   }
// }
