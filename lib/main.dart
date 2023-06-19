import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_user_side/userside/model/cartusermodel.dart';
import 'package:firebase_user_side/userside/model/usermodel.dart';
import 'package:firebase_user_side/userside/view/buyscreen.dart';
import 'package:firebase_user_side/userside/view/cart_screen.dart';
import 'package:firebase_user_side/userside/view/favouritescreen.dart';
import 'package:firebase_user_side/userside/view/home_screen.dart';
import 'package:firebase_user_side/userside/view/menuscreen.dart';
import 'package:firebase_user_side/userside/view/second_screen.dart';
import 'package:firebase_user_side/userside/view/sign_in.dart';
import 'package:firebase_user_side/userside/view/signup_dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'userside/view/splash_screen.dart';

List<Usermodel> UsermodelList=[];
List<usercartmodel> cartList=[];
List<userordermodel>buyList=[];


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) =>  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page :() => Splash_screen()),
        GetPage(name: '/In', page :() => SignIn()),
        GetPage(name: '/up', page :() => SignUp()),
        GetPage(name: '/home', page :() => Home_screen()),
        GetPage(name: '/second', page: () => second_screen()),
        GetPage(name: '/menu', page: () => menuscreen()),
        GetPage(name: '/cart', page: () => cartscreen()),
        GetPage(name: '/f', page: () => fscreen()),
        GetPage(name: '/buy', page: () => Buyscreen()),
      ],
  ),
    ),
  );
}
