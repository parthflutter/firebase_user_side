import 'package:firebase_user_side/ulitis/fbhelper_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../model/usermodel.dart';

class second_screen extends StatefulWidget {
  const second_screen({Key? key}) : super(key: key);

  @override
  State<second_screen> createState() => _second_screenState();
}

class _second_screenState extends State<second_screen> {
  @override
  Usermodel? usermodel;

  void initState() {
    // TODO: implement initState
    super.initState();
    usermodel = Get.arguments;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, size: 25, color: Colors.white),
                  Spacer(),
                  Icon(Icons.shopping_bag, size: 25, color: Colors.white),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 40.h,
                  width: 100.w,
                  child:
                      Image.network("${usermodel!.image}", fit: BoxFit.cover),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: Container(
                      height: 54.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.black,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${usermodel!.name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white)),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("\$${usermodel!.price}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white)),
                          ),
                          SizedBox(height: 1.h),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Product Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Good Food",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.timer,
                                    color: Colors.white, size: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "Delivery Time : 30 minutes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Mc Donald",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                            ],
                          ),
                          SizedBox(height: 9.h),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Firebasehelper.fireHelper.insertitem(
                                    Name: usermodel!.name,
                                    Quantity: usermodel!.quantity,
                                    Category: usermodel!.category,
                                    Price: usermodel!.price,
                                    Image: usermodel!.image);
                                Get.toNamed('/home');
                              },
                              child: Text("Add To Cart"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellowAccent.shade700,
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
