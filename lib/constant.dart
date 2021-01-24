import 'package:flutter/material.dart';

const Color kdarkBlue = Color(0xFF006BFF);

const TextStyle kloginText = TextStyle(
  color: Colors.white,
  fontSize: 50,
  fontWeight: FontWeight.w400,
);

const BoxDecoration kloginContainerDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      offset: Offset(10, -6),
      spreadRadius: 2,
      blurRadius: 35,
    ),
    BoxShadow(
      color: Colors.black26,
      offset: Offset(-20, -6),
      spreadRadius: 2,
      blurRadius: 35,
    )
  ],
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40),
  ),
);

const InputDecoration klogininput = InputDecoration(
  icon: Icon(
    Icons.email_outlined,
    color: kdarkBlue,
  ),
  hintText: 'E-mail address',
);
