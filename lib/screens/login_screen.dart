import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helping_hands_app/constant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../service/auth_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isStartRegister = false;

  Future<void> tryLoginUser(
      {String email,
      String password,
      String username,
      bool islogin,
      BuildContext ctx}) async {
    UserCredential authUser;
    try {
      setState(() {
        _isStartRegister = true;
      });
      if (islogin) {
        authUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      setState(() {
        _isStartRegister = false;
      });
    } on PlatformException catch (err) {
      setState(() {
        _isStartRegister = false;
      });
      String msg = 'Something went wrong please try again later';
      if (err.message != null) {
        msg = err.message;
      }
      print(err.message);
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (err) {
      setState(() {
        _isStartRegister = false;
      });
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(err.message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          backgroundColor: kdarkBlue,
        ),
        inAsyncCall: _isStartRegister,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Helping',
                      style: kloginText,
                    ),
                    Text(
                      'Hands',
                      style: kloginText.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              Expanded(
                child: Container(
                  decoration: kloginContainerDecoration,
                  child: AuthForm(tryLoginUser),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
