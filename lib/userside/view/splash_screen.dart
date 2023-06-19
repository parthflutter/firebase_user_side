import 'dart:async';
import 'package:firebase_user_side/ulitis/fbhelper_dart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  bool? isLogin;
  @override
  void initState() {
    super.initState();
    isLogin = Firebasehelper.fireHelper.checkUser();
  }
  Widget build(BuildContext context) {
     Timer(Duration(seconds: 4), () {Navigator.pushReplacementNamed(context, isLogin!?'home':'In');});
    return SafeArea(
      child: Scaffold(
          body: Container(
            height: 100.h,
            width: 100.w,
            color: Colors.white,
            alignment: Alignment.center,
            child: Image.asset("assets/images/bu.png",fit: BoxFit.fill),
          ),
      ),
    );
  }
}

