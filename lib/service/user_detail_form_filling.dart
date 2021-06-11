import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDetailFromFilling {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<String> putUserImage(
      {String path1, String path2, File pickedImage}) async {
    String userImageUrl;
    final ref = _firebaseStorage.ref().child(path1).child(path2);
    await ref.putFile(pickedImage).whenComplete(
      () async {
        userImageUrl = await ref.getDownloadURL();
      },
    );
    return userImageUrl;
  }

  static Future<void> createUserDoc({
    String userAddress,
    String userContact,
    String userImageUrl,
    String userName,
    String currentUserUID,
  }) async {
    await _firestore.collection('users').doc(currentUserUID).set(
      {
        'address': userAddress,
        'contact': userContact,
        'image': userImageUrl,
        'name': userName,
        'totalBookings': 0,
        'bookings': [],
      },
    );
  }
}
