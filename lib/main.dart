import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/screens/login_screen.dart';

import './screens/category_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   bool theme1 =false;

  void changetheme()
  {
    setState(() {
       theme1=!theme1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme1?ThemeData.dark():ThemeData(
        accentColor: Colors.white,
        primaryColor: Color(0xFF006BFF),
        fontFamily: 'Montserrat',
      ),
       title: 'Helping Hands',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapShot) {
          if (userSnapShot.hasData) {
            return CategoryScreen(changetheme);
          }
          return LoginScreen();
        },
      ),
      routes: {
        LoginScreen.loginScreen: (context) => LoginScreen(),
        CategoryScreen.categoryScreen: (context) => CategoryScreen(changetheme),
      },
    );
  }
}
