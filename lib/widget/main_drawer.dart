import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';
import 'package:helping_hands_app/screens/about_us.dart';
import 'package:helping_hands_app/screens/privacy_policy.dart';

import '../screens/user_profile_screen.dart';
import '../screens/user_bookings.dart';

class MainDrawer extends StatelessWidget {
  final void Function(BuildContext context) logoutFun;
  final BuildContext ctx;

  MainDrawer({this.logoutFun, this.ctx});

  Widget buildListTile(String text, IconData icon, Function onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: kdarkBlue),
      title: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 20),
            color: kdarkBlue,
            width: double.infinity,
            height: 150,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/logo2.png'),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Helping Hands',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          buildListTile(
            'Your Profile',
            Icons.account_circle,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                UserProfile.userProfileScreen,
              );
            },
          ),
          SizedBox(height: 10),
          buildListTile('Your Bookings', Icons.book, () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(UserBookings.user_booking_route);
          }),
          SizedBox(height: 10),
          buildListTile(
            'User Privacy Policy',
            Icons.privacy_tip,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(PrivacyPolicy.privacyPolicy);
            },
          ),
          SizedBox(height: 10),
          buildListTile(
            'About Us',
            Icons.assignment,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AboutUs.aboutUs);
            },
          ),
          SizedBox(height: 10),
          buildListTile(
            'Logout',
            Icons.logout,
            () {
              Navigator.of(context).pop();
              logoutFun(ctx);
            },
          ),
        ],
      ),
    );
  }
}

// SafeArea(
// child: ListTile(
// leading: ClipRRect(
// borderRadius: BorderRadius.circular(30),
// child: imageUrl != ''
// ? FadeInImage(
// height: 58,
// width: 56,
// fit: BoxFit.fill,
// placeholder:
// AssetImage('assets/images/user_avatar.PNG'),
// image: NetworkImage(imageUrl),
// )
// : AssetImage('assets/images/user_avatar.PNG'),
// ),
//
// // CircleAvatar(
// //   backgroundColor: Colors.white,
// //   radius: 28,
// //   backgroundImage: imageUrl != ''
// //       ? FadeInImage(
// //           placeholder: AssetImage('assets/images/logo.jpg'),
// //           image: NetworkImage(imageUrl),
// //         )
// //       : AssetImage('assets/images/ee.PNG'),
// // ),
// title: Text(
// 'Welcome!',
// style: TextStyle(
// fontSize: 30,
// color: Colors.white,
// fontWeight: FontWeight.w600,
// letterSpacing: 1,
// ),
// ),
// subtitle: Text(
// userName,
// style: TextStyle(
// fontSize: 18,
// color: Colors.white,
// letterSpacing: 1.5,
// ),
// maxLines: 1,
// ),
// )
