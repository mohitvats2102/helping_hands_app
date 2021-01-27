import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helping_hands_app/constant.dart';
import 'package:helping_hands_app/demo_examples.dart';
import 'package:helping_hands_app/screens/login_screen.dart';
import 'package:helping_hands_app/widget/category_item.dart';

import '../widget/base_ui.dart';

class CategoryScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String categoryScreen = '/categoryScreen';

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
                      const Icon(Icons.logout, color: kdarkBlue),
                      const SizedBox(width: 10),
                      const Text("Logout", style: TextStyle(color: kdarkBlue)),
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
          padding: const EdgeInsets.only(left: 18, top: 10),
          text1: 'Choose Your',
          text2: 'Service',
          height: 30,
          fontsize: 40,
          fontWeight: FontWeight.w800,
          radius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 4),
            child: GridView(
              // scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: Demo_Example.map(
                (catData) => CategoryItem(
                  catData.id,
                  catData.title,
                  catData.assetImage,
                ),
              ).toList(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
