import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF006BFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
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
              Form(
                child: Column(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
