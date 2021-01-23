import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';

class BaseUI extends StatelessWidget {
  final EdgeInsets padding;
  final String text1, text2;
  final double height;
  final FontWeight fontWeight;
  final double fontsize;
  final Widget child;
  final BorderRadius radius;

  BaseUI(
      {this.fontWeight,
      this.padding,
      this.text2,
      this.text1,
      this.height,
      this.child,
      this.fontsize,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: kloginText.copyWith(fontSize: fontsize),
              ),
              Text(
                text2,
                style: kloginText.copyWith(
                  fontSize: fontsize,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height),
        Expanded(
          child: Container(
            decoration: kloginContainerDecoration.copyWith(
              borderRadius: radius,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
