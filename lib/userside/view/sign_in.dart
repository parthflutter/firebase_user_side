import 'package:firebase_user_side/ulitis/fbhelper_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 1.h),
                Text(
                  "SignIn",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 150.sp),
                // Image(image: NetworkImage("https://wallpapercave.com/wp/wp2939900.jpg")),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: txtemail,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 1.5, color: Colors.red)),
                      labelText: 'Email',
                      prefixIcon:
                      Icon(Icons.email_outlined, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: txtpassword,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 1.5, color: Colors.red)),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed('/up');
                    },
                    child: Text('Create a New Account ?  Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.sp))),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    String email = txtemail.text;
                    String password = txtpassword.text;
                    String? isLogin = await Firebasehelper.fireHelper
                        .signIn(email: email, password: password);
                    if (isLogin == "success") {
                      Get.snackbar('Login Successful', "");
                      Get.offAndToNamed('/home');
                    } else {
                      Get.snackbar('$isLogin', "");
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 7.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text('Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        String? msg =
                        await Firebasehelper.fireHelper.google_SignIn();
                        print('${msg}=====================');
                        if (msg == "Success") {
                          Get.toNamed('/home');
                        } else {
                          Get.snackbar('title', '$msg');
                        }
                      },
                      child: Text(
                        "GOOGLE",
                        style: TextStyle(color: Colors.black),
                      ),
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
