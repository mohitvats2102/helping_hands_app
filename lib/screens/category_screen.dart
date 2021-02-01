import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helping_hands_app/demo_examples.dart';
import 'package:helping_hands_app/screens/login_screen.dart';
import 'package:helping_hands_app/widget/category_item.dart';

import '../widget/base_ui.dart';
import '../widget/main_drawer.dart';

class CategoryScreen extends StatelessWidget {
  static const String categoryScreen = '/categoryScreen';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _userImageUrl = '';
  String _userName = '';

  void logout(BuildContext context) async {
    if (_auth.currentUser.providerData != null) {
      if (_auth.currentUser.providerData[0].providerId == 'google.com') {
        print('In If BLOCK');
        await GoogleSignIn().disconnect();
      }
    }
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    _userImageUrl = _auth.currentUser.photoURL ?? '';
    _userName = _auth.currentUser.displayName ?? '';
    return Scaffold(
      drawer: MainDrawer(
        imageUrl: _userImageUrl,
        userName: _userName,
        logoutFun: logout,
        ctx: context,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        // actions: [
        //   DropdownButtonHideUnderline(
        //     child: DropdownButton(
        //       icon: Padding(
        //         padding: const EdgeInsets.only(right: 10, top: 7),
        //         child: Icon(Icons.more_vert, color: Colors.white),
        //       ),
        //       items: [
        //         DropdownMenuItem(
        //           value: "Logout",
        //           child: Row(
        //             children: [
        //               const Icon(Icons.logout, color: kdarkBlue),
        //               const SizedBox(width: 10),
        //               const Text("Logout", style: TextStyle(color: kdarkBlue)),
        //             ],
        //           ),
        //         )
        //       ],
        //       onChanged: (itemIdentifier) {
        //         if (itemIdentifier == 'Logout') {
        //           print('User Data : ${_auth.currentUser}');
        //           logout(context);
        //         }
        //       },
        //     ),
        //   )
        // ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: BaseUI(
          fontWeight2: FontWeight.w500,
          padding: const EdgeInsets.only(left: 18, top: 10),
          text1: 'Choose Your',
          text2: 'Service',
          height: 60,
          fontsize1: 40,
          fontsize2: 40,
          fontWeight1: FontWeight.w800,
          radius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 4),
            child: GridView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: Demo_Example.map(
                (catData) => CategoryItem(
                  catData.id,
                  catData.title,
                  catData.assetImage,
                ),
              ).toList(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
