import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helping_hands_app/constant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../screens/category_screen.dart';
import '../screens/user_details_screen.dart';
import '../service/auth_form.dart';
import '../widget/base_ui.dart';

class LoginScreen extends StatefulWidget {
  static const String loginScreen = '/loginscreen';

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
      if (islogin) {
        if (this.mounted) {
          setState(() {
            _isStartRegister = true;
          });
        }
        authUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        if (this.mounted) {
          setState(() {
            _isStartRegister = false;
          });
        }

        Navigator.of(context)
            .pushReplacementNamed(CategoryScreen.categoryScreen);
      } else {
        var data = await Navigator.of(context)
            .pushNamed(UserDetailScreen.userDetailScreen, arguments: {
          'username': username,
          'email': email,
          'password': password,
        });
        if (data == true) {
          Navigator.of(context)
              .pushReplacementNamed(CategoryScreen.categoryScreen);
        } else if (data != null) {
          showDialog(
            context: context,
            builder: (context) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: AlertDialog(
                  title: Text(
                    data,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          color: kdarkBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }
    } on PlatformException catch (err) {
      if (this.mounted) {
        setState(() {
          _isStartRegister = false;
        });
      }
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
      if (this.mounted) {
        setState(() {
          _isStartRegister = false;
        });
      }
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
        inAsyncCall: _isStartRegister,
        child: SafeArea(
          child: BaseUI(
            padding: const EdgeInsets.only(
                left: 18, top: 20), //this is to simplyfy widget tree
            text1: 'Helping',
            text2: 'Hands',
            fontWeight: FontWeight.w900,
            fontsize: 50,
            height: 100,
            radius: BorderRadius.only(
              topLeft: Radius.circular(40),
            ),
            child: AuthForm(tryLoginUser),
          ),
        ),
      ),
    );
  }
}
