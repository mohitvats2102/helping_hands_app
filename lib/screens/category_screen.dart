import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';
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
      appBar: AppBar(
        leading: Image.asset('assets/images/logo1.PNG'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Padding(
                padding: const EdgeInsets.only(right: 10, top: 7),
                child: Icon(Icons.more_vert, color: Colors.white),
              ),
              items: [
                DropdownMenuItem(
                  value: "Logout",
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: kdarkBlue),
                      SizedBox(width: 10),
                      Text("Logout", style: TextStyle(color: kdarkBlue)),
                    ],
                  ),
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'Logout') {
                  logout(context);
                }
              },
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: BaseUI(
          padding: const EdgeInsets.only(left: 18),
          text1: 'Choose Your',
          text2: 'Service',
          height: 45,
          fontsize: 35,
          fontWeight: FontWeight.w800,
          radius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 4),
            child: GridView(
              children: Demo_Example.map(
                (catData) => GridViewFileFrame(
                  catData.id,
                  catData.title,
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
