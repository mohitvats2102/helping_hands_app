import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helping_hands_app/constant.dart';

class UserBookings extends StatefulWidget {
  static const String user_booking_route = '/user_booking_route';

  @override
  _UserBookingsState createState() => _UserBookingsState();
}

class _UserBookingsState extends State<UserBookings> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userUID;
  DocumentSnapshot _userDoc;
  List userBookingsIDs = [];

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    userUID = _auth.currentUser.uid;
    _userDoc = await _firestore.collection('users').doc(userUID).get();
    userBookingsIDs = _userDoc.data()['bookings'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookings'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _firestore.collection('bookings').orderBy('booking_time').get(),
        builder: (ctx, asyncSnap) {
          if (asyncSnap.hasError) {
            return Center(
              child: Text('Something went Wrong'),
            );
          }
          if (asyncSnap.connectionState == ConnectionState.done) {
            List<QueryDocumentSnapshot> userBookings = [];
            userBookings = asyncSnap.data.docs.where((bookingId) {
              return userBookingsIDs.contains(bookingId.id);
            }).toList();

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          userBookings[i].data()['booker'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          userBookings[i].data()['booking_date'],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        trailing: Text(
                          userBookings[i].data()['booking_time'],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
              itemCount: userBookings.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: kdarkBlue,
            ),
          );
        },
      ),
    );
  }
}
