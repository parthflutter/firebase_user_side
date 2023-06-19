import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_user_side/main.dart';
import 'package:firebase_user_side/userside/controller/h_controller.dart';
import 'package:firebase_user_side/userside/model/cartusermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../../ulitis/fbhelper_dart.dart';

class cartscreen extends StatefulWidget {
  const cartscreen({Key? key}) : super(key: key);

  @override
  State<cartscreen> createState() => _cartscreenState();
}

class _cartscreenState extends State<cartscreen> {
  Home_controller home = Get.put(Home_controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          for(int i=0;i<cartList.length;i++)
            {
              Map<String,dynamic> m1=
              {
                "Name":"${cartList[i].name}",
                "Price":"${cartList[i].price}",
                "Image":"${cartList[i].image}",
                "category":"${cartList[i].category}",
              };
              Firebasehelper.fireHelper.buyinsertitem(m1);
            };
          Get.toNamed('/buy');
        },child: Text("Buy",),),
        backgroundColor: Colors.black,
        body: StreamBuilder(
          stream: Firebasehelper.fireHelper.readcartitem(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(("${snapshot.error}"));
            } else if (snapshot.hasData) {
              QuerySnapshot? q = snapshot.data;
              cartList.clear();
              for (var x in q!.docs) {
                Map data = x.data() as Map;
                String name = '${data['Name']}';
                String price = '${data['Price']}';
                String image = '${data['Image']}';
                String quantity = '${data['Quantity']}';
                String category = '${data['Category']}';
                var key = x.id;
                usercartmodel m1 = usercartmodel(
                  image: image,
                  price: price,
                  quantity: quantity,
                  key: key,
                  name: name,
                  category: category,
                );
                cartList.add(m1);
              }
              return ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100.w,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 10.h,
                            width: 25.w,
                            child: Image.network(
                                "${cartList[index].image}",
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 53.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${cartList[index].name}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "${cartList[index].price}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    var key=cartList[index].key;
                                    Firebasehelper.fireHelper.delete(key!);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                               ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
