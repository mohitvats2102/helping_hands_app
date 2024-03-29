import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helping_hands_app/constant.dart';
import 'package:helping_hands_app/screens/login_screen.dart';
import 'package:helping_hands_app/widget/category_item.dart';

import '../widget/base_ui.dart';
import '../widget/main_drawer.dart';

class CategoryScreen extends StatelessWidget {
  static const String categoryScreen = '/categoryScreen';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void logout(BuildContext context) async {
    if (_auth.currentUser.providerData != null) {
      if (_auth.currentUser.providerData[0].providerId == 'google.com') {
        await GoogleSignIn().disconnect();
      }
    }
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(
        logoutFun: logout,
        ctx: context,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
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
            child: FutureBuilder<QuerySnapshot>(
              future: _firestore.collection('categories').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> _docSnap = snapshot.data.docs;

                    return GridView.builder(
                      itemCount: _docSnap.length,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemBuilder: (context, index) {
                        return CategoryItem(
                          _docSnap[index].data()['name'],
                          _docSnap[index].data()['image'],
                          _docSnap[index].id,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10,
                      ),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(color: kdarkBlue),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

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
