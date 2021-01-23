import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/screens/login_screen.dart';
import 'package:helping_hands_app/screens/worker_screen.dart';

import './screens/category_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.white,
        primaryColor: Color(0xFF006BFF),
        fontFamily: 'Montserrat',
      ),
      title: 'Helping Hands',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapShot) {
          if (userSnapShot.hasData) {
            return CategoryScreen();
          }
          return LoginScreen();
        },
      ),
      routes: {
        LoginScreen.loginScreen: (context) => LoginScreen(),
        CategoryScreen.categoryScreen: (context) => CategoryScreen(),
        WorkerScreen.workerscreen:(context)=>WorkerScreen()
      },
    );
  }
}
