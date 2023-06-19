import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../main.dart';
import '../../ulitis/fbhelper_dart.dart';
import '../model/usermodel.dart';

class Buyscreen extends StatefulWidget {
  const Buyscreen({Key? key}) : super(key: key);

  @override
  State<Buyscreen> createState() => _BuyscreenState();
}

class _BuyscreenState extends State<Buyscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Buy Product",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
        body: StreamBuilder(
    stream: Firebasehelper.fireHelper.readbuyitem(),
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
              qua: 1,
            );
            UsermodelList.add(m1);
          }
          return ListView.builder(
            itemCount: UsermodelList.length,
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
                            "${UsermodelList[index].image}",
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 55.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${UsermodelList[index].name}",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "${UsermodelList[index].price}",
                                style: TextStyle(fontSize: 15),
                              ),
                              ElevatedButton(onPressed: (){
                                Get.snackbar("Order", "Order Successful",colorText: Colors.white);
                              }, style: ElevatedButton.styleFrom(backgroundColor: Colors.black26)
                                ,child:Text("Place Order",),),
                            ],
                          ),

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
