import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../ulitis/fbhelper_dart.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    "SignUp",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 150.sp),
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
                  TextButton(onPressed: () {
                    Get.offAndToNamed('/In');
                  },
                    child: Text('Already Register Your Account ? Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      String email = txtemail.text;
                      String password = txtpassword.text;
                      Firebasehelper.fireHelper.signUP(email: email, password: password);
                      Get.back();
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
                      child: Text('SignUp',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}


