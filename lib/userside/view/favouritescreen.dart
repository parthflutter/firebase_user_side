import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class fscreen extends StatefulWidget {
  const fscreen({Key? key}) : super(key: key);

  @override
  State<fscreen> createState() => _fscreenState();
}

class _fscreenState extends State<fscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(),
    ),);
  }
}
