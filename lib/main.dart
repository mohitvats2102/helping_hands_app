import 'package:flutter/material.dart';
import 'package:helping_hands_app/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      title: 'Helping Hands',
      home: LoginScreen(),
    );
  }
}
