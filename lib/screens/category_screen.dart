import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/Widget/GridViewFileFrame.dart';
import 'package:helping_hands_app/demo_examples.dart';

class CategoryScreen extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String categoryScreen = '/categoryScreen';
  final Function changetheme;
  CategoryScreen(this.changetheme);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ctaegories"),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(value: "Theme", child: Text("Theme")),
                DropdownMenuItem(value: "Logout", child: Text("Logout"))
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'Theme') {
                  widget.changetheme();
                }
                if (itemIdentifier == 'Logout') {
                  logout();
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
