import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shoreguard/screens/homescreen.dart';
import 'package:shoreguard/screens/loginscreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Image.asset(
          'assets/images/REvan_logo-01.png',
          height: double.maxFinite,
        ),
      ),
    );
  }
}
