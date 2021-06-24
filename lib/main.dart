import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helping_hands_app/screens/login_screen.dart';
import 'package:helping_hands_app/screens/user_detail_form.dart';
import 'package:helping_hands_app/screens/worker_screen.dart';
import 'package:page_transition/page_transition.dart';

import './screens/category_screen.dart';
import './screens/confirm_booking.dart';
import './screens/user_profile_screen.dart';
import './screens/worker_detail_screen.dart';
import './screens/user_bookings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  User _firebaseUser = FirebaseAuth.instance.currentUser;
  if (_firebaseUser != null) {
    bool _doesContain = false;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot _usersCollection = await _firestore.collection('users').get();
    List<QueryDocumentSnapshot> _usersCollectionDOC = _usersCollection.docs;

    for (int i = 0; i < _usersCollectionDOC.length; i++) {
      if (_usersCollectionDOC[i].id == _firebaseUser.uid) {
        _doesContain = true;
      }
    }
    runApp(MyApp(doesContain: _doesContain));
  } else
    runApp(MyApp(doesContain: null));
}

class MyApp extends StatelessWidget {
  final bool doesContain;
  MyApp({this.doesContain});

  final User _firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Widget _firstWidget;

  @override
  Widget build(BuildContext context) {
    if (doesContain == null) {
      if (_firebaseUser == null) {
        _firstWidget = LoginScreen();
      } else {
        _firstWidget = CategoryScreen();
      }
    } else {
      if (!doesContain)
        _firstWidget = UserDetailForm();
      else
        _firstWidget = CategoryScreen();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.white,
        primaryColor: Color(0xFF006BFF),
        fontFamily: 'Montserrat',
      ),
      title: 'Helping Hands',
      home: _firstWidget,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case LoginScreen.loginScreen:
            return PageTransition(
              child: LoginScreen(),
              curve: Curves.linear,
              type: PageTransitionType.topToBottom,
            );
            break;

          case CategoryScreen.categoryScreen:
            return PageTransition(
              child: CategoryScreen(),
              curve: Curves.linear,
              type: PageTransitionType.bottomToTop,
            );
            break;
          case WorkerScreen.workerscreen:
            return PageTransition(
              child: WorkerScreen(),
              curve: Curves.linear,
              // childCurrent: this,  childCurrent is used when we use any 'joined' page transition
              type: PageTransitionType.rightToLeftWithFade,
              settings:
                  settings, //setting argument is used when we are passing Data through NamedRoutes just like in WorkerScreen()
            );
            break;
          case WorkerDetailScreen.worker_route:
            return PageTransition(
              child: WorkerDetailScreen(),
              curve: Curves.linear,
              type: PageTransitionType.rightToLeftWithFade,
              settings:
                  settings, //setting argument is used when we are passing Data through NamedRoutes just like in WorkerScreen()
            );
            break;
          case BookingScreen.bookingPageRoute:
            return PageTransition(
              child: BookingScreen(),
              curve: Curves.linear,
              type: PageTransitionType.rightToLeftWithFade,
              settings:
                  settings, //setting argument is used when we are passing Data through NamedRoutes just like in WorkerScreen()
            );
            break;
          case UserProfile.userProfileScreen:
            return PageTransition(
              child: UserProfile(),
              curve: Curves.linear,
              type: PageTransitionType.rightToLeftWithFade,
              settings:
                  settings, //setting argument is used when we are passing Data through NamedRoutes just like in WorkerScreen()
            );
            break;
          case UserBookings.user_booking_route:
            return PageTransition(
              child: UserBookings(),
              curve: Curves.linear,
              type: PageTransitionType.rightToLeftWithFade,
              settings:
                  settings, //setting argument is used when we are passing Data through NamedRoutes just like in WorkerScreen()
            );
            break;
          case UserDetailForm.workerDetailForm:
            return PageTransition(
              child: UserDetailForm(),
              curve: Curves.linear,
              type: PageTransitionType.rightToLeftWithFade,
              settings:
                  settings, //setting argument is used when we are passing Data through NamedRoutes just like in WorkerScreen()
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}

// StreamBuilder<User>(
// stream: FirebaseAuth.instance.authStateChanges(),
// builder: (ctx, userSnapShot) {
// if (userSnapShot.hasData) {
// return CategoryScreen();
// }
// return LoginScreen();
// },
// )
