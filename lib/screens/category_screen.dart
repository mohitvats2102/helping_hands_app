import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/Widget/GridViewFileFrame.dart';
import 'package:helping_hands_app/demo_examples.dart';
import 'package:helping_hands_app/screens/login_screen.dart';

class CategoryScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String categoryScreen = '/categoryScreen';
  final Function changetheme;
  CategoryScreen(this.changetheme);

  void logout(BuildContext context) {
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CATEGORIES",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.more_vert, color: Colors.white),
              ),
              items: [
                DropdownMenuItem(
                  value: 'Change Theme',
                  child: Text(
                    "Theme",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "Logout",
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'Change Theme') {
                  changetheme();
                }
                if (itemIdentifier == 'Logout') {
                  logout(context);
                }
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: GridView(
          children: Demo_Example.map(
            (catData) => GridViewFileFrame(
              catData.id,
              catData.title,
              catData.color,
            ),
          ).toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 50,
          ),
        ),
      ),
    );
  }
}
