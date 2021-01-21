import 'package:flutter/material.dart';

const TextStyle kloginText = TextStyle(
  color: Colors.white,
  fontSize: 45,
  fontWeight: FontWeight.w400,
);

const BoxDecoration kloginContainerDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(10, -6),
      spreadRadius: 2,
      blurRadius: 20,
    ),
    BoxShadow(
      color: Colors.black12,
      offset: Offset(-20, -6),
      spreadRadius: 0,
      blurRadius: 40,
    )
  ],
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40),
  ),
);

const InputDecoration klogininput = InputDecoration(
  focusColor: Colors.amber,
  icon: Icon(
    Icons.email_outlined,
    color: Color(0xFF006BFF),
  ),
  hintText: 'E-mail address',
);
