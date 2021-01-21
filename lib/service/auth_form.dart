import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: klogininput,
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: klogininput.copyWith(
                  hintText: 'password',
                  icon: Icon(
                    Icons.lock_outline,
                    color: Color(0xFF006BFF),
                  ),
                ),
              ),
              SizedBox(height: 30),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                color: Color(0xFF006BFF),
              ),
              SizedBox(height: 70),
              Text(
                'Don\'t have any account.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006BFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
