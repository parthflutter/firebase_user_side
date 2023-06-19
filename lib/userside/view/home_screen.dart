import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_user_side/userside/controller/h_controller.dart';
import 'package:firebase_user_side/userside/model/usermodel.dart';
import 'package:firebase_user_side/userside/view/favouritescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';
import '../../ulitis/fbhelper_dart.dart';
import 'cart_screen.dart';
import 'menuscreen.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  @override
  Usermodel? usermodel;
  Home_controller home = Get.put(Home_controller());

  void initState() {
    super.initState();
    usermodel = Get.arguments;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Food"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications_active,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.black38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(radius: 60),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Parth Savaliya",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "savaliyaparth712@gmail.com",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Setting"),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share with friend"),
              ),
              ListTile(
                leading: Icon(Icons.error),
                title: Text("About us"),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text("Help"),
              ),
              ListTile(
                leading: IconButton(
                    onPressed: () async {
                      bool? msg = await Firebasehelper.fireHelper.logout();
                      if (msg = true) {
                        Get.offNamed("In");
                        Get.snackbar("True", "$msg");
                      }
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    )),
                title: Text("Logout"),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () =>  BottomNavigationBar(
            onTap: (value) {
              home.i.value=value;
            },
            currentIndex: home.i.value,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_basket,
                  ),
                  label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favourite"),
            ],
          ),
        ),
        body: Obx(() => home.screenList[home.i.value]),
      ),
    );
  }
}
