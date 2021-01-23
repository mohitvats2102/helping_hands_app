import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/demo_examples.dart';
import 'package:helping_hands_app/screens/login_screen.dart';
import 'package:helping_hands_app/widget/GridViewFileFrame.dart';

import '../widget/base_ui.dart';

class CategoryScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String categoryScreen = '/categoryScreen';

  void logout(BuildContext context) {
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              logout(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 13),
              child: Icon(Icons.logout, color: Colors.white, size: 25),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: BaseUI(
          padding: const EdgeInsets.only(left: 18),
          text1: 'Choose Your',
          text2: 'Category',
          height: 50,
          fontsize: 40,
          fontWeight: FontWeight.w800,
          radius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 4),
            child: GridView(
              children: Demo_Example.map(
                (catData) => GridViewFileFrame(
                  catData.id,
                  catData.title,
                  catData.color,
                  catData.assetImage,
                ),
              ).toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.9,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Padding(
// padding: const EdgeInsets.only(left: 18),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Choose Your',
// style: kloginText.copyWith(fontSize: 40),
// ),
// Text(
// 'Category',
// style: kloginText.copyWith(
// fontWeight: FontWeight.w800,
// fontSize: 40,
// ),
// ),
// ],
// ),
// ),
// SizedBox(height: 50),
// Expanded(
// child: Container(
// decoration: kloginContainerDecoration.copyWith(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(20),
// topRight: Radius.circular(20),
// ),
// ),
// child: Padding(
// padding: const EdgeInsets.only(
// left: 12, top: 10, right: 12, bottom: 4),
// child: GridView(
// children: Demo_Example.map(
// (catData) => GridViewFileFrame(
// catData.id,
// catData.title,
// catData.color,
// catData.assetImage,
// ),
// ).toList(),
// gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
// maxCrossAxisExtent: 200,
// childAspectRatio: 0.9,
// crossAxisSpacing: 20,
// mainAxisSpacing: 20,
// ),
// ),
// ),
// ),
// ),
//  ],
//  ),

// appBar: AppBar(
// title: Text(
// "CATEGORIES",
// style: TextStyle(fontWeight: FontWeight.bold),
// ),
// actions: [
// DropdownButtonHideUnderline(
// child: DropdownButton(
// icon: Padding(
// padding: const EdgeInsets.all(10.0),
// child: Icon(Icons.more_vert, color: Colors.white),
// ),
// items: [
// DropdownMenuItem(
// value: "Logout",
// child: Text(
// "Logout",
// style: TextStyle(
// fontWeight: FontWeight.w500,
// ),
// ),
// )
// ],
// onChanged: (itemIdentifier) {
// if (itemIdentifier == 'Logout') {
// logout(context);
// }
// },
// ),
// )
// ],
// ),
