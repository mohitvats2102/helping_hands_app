import 'dart:ui';

import 'package:flutter/material.dart';

import '../widget/base_ui.dart';
import 'otpscreen.dart';

class PhoneVerification extends StatefulWidget {
  static const String phoneVerificationScreen = '/phone_route';
  @override
  _State createState() => _State();
}

class _State extends State<PhoneVerification> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: BaseUI(
          padding: const EdgeInsets.only(
              left: 18, top: 20), //this is to simplyfy widget tree
          text1: 'Helping',
          text2: 'Hands',
          fontWeight2: FontWeight.w900,
          fontsize1: 50,
          height: 100,
          radius: BorderRadius.only(
            topLeft: Radius.circular(40),
          ),

          child: Form(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
              child: Column(
                children: [
                  Text(
                    "Verify with phone number",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    key: ValueKey('phone'),
                    controller: _controller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Phone number"),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OTPScreen(_controller.text),
                        ),
                      );
                    },
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _verifyPhone {}

mixin AuthResult {}

mixin FirebaseUser {}

// import 'dart:ui';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../widget/base_ui.dart';
// import 'category_screen.dart';
//
// class PhoneVerification extends StatefulWidget {
//   static const String phoneVerificationScreen = '/phone_route';
//   @override
//   _State createState() => _State();
// }
//
// class _State extends State<PhoneVerification> {
//   final _phoneController = TextEditingController();
//   final _codeController = TextEditingController();
//
//   Future<void> loginUser(String phone, BuildContext context) async {
//     print('in login user');
//     FirebaseAuth _auth = FirebaseAuth.instance;
//     FirebaseUser user;
//
//     await _auth.verifyPhoneNumber(
//       phoneNumber: '+91 $phone',
//       timeout: Duration(seconds: 60),
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         print('in verification complete');
//         Navigator.of(context).pop();
//
//         UserCredential result = await _auth.signInWithCredential(credential);
//
//         user = result.user as FirebaseUser;
//
//         if (user != null) {
//           // Navigator.push(
//           //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
//           Navigator.of(context).pushNamed(CategoryScreen.categoryScreen);
//         } else {
//           print("Error");
//         }
//
//         //This callback would gets called when verification is done auto maticlly
//       },
//       verificationFailed: (FirebaseAuthException exception) {
//         print('in verification failed');
//         print(exception);
//       },
//       codeSent: (String verificationId, int forceResendingToken) {
//         print('in code sent');
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) {
//             return AlertDialog(
//               title: Text("Give the code?"),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   TextField(
//                     controller: _codeController,
//                   ),
//                 ],
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text("Confirm"),
//                   textColor: Colors.white,
//                   color: Colors.blue,
//                   onPressed: () async {
//                     final code = _codeController.text.trim();
//                     AuthCredential credential = PhoneAuthProvider.credential(
//                         verificationId: verificationId, smsCode: code);
//
//                     UserCredential user =
//                         await _auth.signInWithCredential(credential);
//
//                     //  FirebaseUser user = result.user;
//
//                     if (user != null) {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => LoginScreen()),
//                       // );
//                       Navigator.of(context)
//                           .pushNamed(CategoryScreen.categoryScreen);
//                       //Navigator.of(context).pushNamed(HomeScreen.routeNames);
//                     } else {
//                       print("Error");
//                     }
//                   },
//                 )
//               ],
//             );
//           },
//         );
//       },
//       codeAutoRetrievalTimeout: (String value) {},
//     );
//     print('in last');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         elevation: 0,
//       ),
//       backgroundColor: Theme.of(context).primaryColor,
//       body: SafeArea(
//         child: BaseUI(
//           padding: const EdgeInsets.only(
//               left: 18, top: 20), //this is to simplyfy widget tree
//           text1: 'Helping',
//           text2: 'Hands',
//           fontWeight2: FontWeight.w900,
//           fontsize1: 50,
//           height: 100,
//           radius: BorderRadius.only(
//             topLeft: Radius.circular(40),
//           ),
//
//           child: Form(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
//               child: Column(
//                 children: [
//                   Text(
//                     "Verify with phone number",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30.0,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   SizedBox(height: 20.0),
//                   TextFormField(
//                     key: ValueKey('phone'),
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0)),
//                         hintText: "Phone number"),
//                   ),
//                   SizedBox(height: 20.0),
//                   RaisedButton(
//                     onPressed: () {
//                       print('in onpressed');
//                       loginUser(_phoneController.text, context);
//                     },
//                     child: Text(
//                       "NEXT",
//                       style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).primaryColor),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// mixin AuthResult {}
//
// mixin FirebaseUser {}
