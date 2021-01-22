import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';
import 'package:helping_hands_app/screens/login_screen.dart';

class CategoryScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String categoryScreen = '/categoryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CategoryScreen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kdarkBlue,
        actions: [
          GestureDetector(
            onTap: () async {
              await _auth.signOut();
              Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.loginScreen);
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text('Category Screen'),
      ),
    );
  }
}
