import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';
import '../../ulitis/fbhelper_dart.dart';
import '../model/usermodel.dart';

class menuscreen extends StatefulWidget {
  const menuscreen({Key? key}) : super(key: key);

  @override
  State<menuscreen> createState() => _menuscreenState();
}

class _menuscreenState extends State<menuscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello,",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                    Text("Every Bite a",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                    Text(" declicious male for",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                    Text("your loved ones and friend",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                  ],
                ),

                Spacer(),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
              ],
            ),

            SizedBox(height: 1.h),
            Expanded(
              child: StreamBuilder(
                stream: Firebasehelper.fireHelper.readitem(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    QuerySnapshot? q = snapshot.data;
                    UsermodelList.clear();
                    for (var x in q!.docs) {
                      Map data = x.data() as Map;
                      String name = '${data['Name']}';
                      String price = '${data['Price']}';
                      String image = '${data['Image']}';
                      String quantity = '${data['Quantity']}';
                      String category = '${data['Category']}';
                      var key = x.id;
                      Usermodel m1 = Usermodel(
                        image: image,
                        price: price,
                        quantity: quantity,
                        key: key,
                        name: name,
                        category: category,
                      );
                      UsermodelList.add(m1);
                    }
                    return GridView.builder(
                      itemCount: UsermodelList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,mainAxisExtent: 290),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(onTap: () {
                            Get.toNamed('/second',arguments: UsermodelList[index]);
                          },
                            child: Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: Colors.yellowAccent.shade200),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height:15.h,
                                        width: 35.w,
                                        child: Image.network("${UsermodelList[index].image}",fit: BoxFit.cover,)),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text("${UsermodelList[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                                  SizedBox(height: 2.h),
                                  Text("\$${UsermodelList[index].price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)),
                                  SizedBox(height: 2.h),
                                  Text("${UsermodelList[index].quantity}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)),
                                  SizedBox(height: 2.h),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
