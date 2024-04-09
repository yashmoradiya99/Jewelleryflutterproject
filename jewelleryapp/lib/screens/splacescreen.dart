import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jewelleryapp/screens/ChangePassword.dart';
import 'package:jewelleryapp/screens/CustomNavigationBar.dart';
import 'package:jewelleryapp/screens/HomeScreen.dart';
import 'package:jewelleryapp/screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splacescreen extends StatefulWidget {
  const splacescreen({super.key});

  @override
  State<splacescreen> createState() => _splacescreenState();
}

class _splacescreenState extends State<splacescreen> {
  // Future<bool?> checkLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var login = prefs.getString("islogin").toString();
  //   print("login = ${login}");
  //   return login != null;
  // }
  late bool isLoggedIn;

  Future<bool?> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login = prefs.getString("islogin");
print("log = ${login}");
    isLoggedIn = login == "yes";
    print("login = ${isLoggedIn}");

    return isLoggedIn;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 1000,
          width: 500,
          child: FutureBuilder(
            future: checkLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (isLoggedIn) {
                  return AnimatedSplashScreen(
                    splash: Image.asset("img/logo2.png", fit: BoxFit.cover, color: Colors.white),
                    duration: 1000,
                    splashTransition: SplashTransition.scaleTransition,
                    backgroundColor:  Color(0xff546e7a),
                    nextScreen: CustomNavigationBar(),
                  );
                } else {
                  return AnimatedSplashScreen(
                    splash: Image.asset("img/logo2.png", fit: BoxFit.cover, color: Colors.white),
                    duration: 1000,
                    splashTransition: SplashTransition.scaleTransition,
                    backgroundColor:  Color(0xff546e7a),
                    nextScreen: LoginScreen(),
                  );
                }
              } else {
                // Loading state or placeholder widget
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}