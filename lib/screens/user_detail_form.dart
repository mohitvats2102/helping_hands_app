import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helping_hands_app/screens/category_screen.dart';

import '../constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../service/user_detail_form_filling.dart';

class UserDetailForm extends StatefulWidget {
  static const String workerDetailForm = '/user_detail_form';

  @override
  _UserDetailFormState createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  bool _isUploadingStarted = false;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _currentUserUID;
  bool doesRun = true;

  File _pickedImage;
  String _userName;
  String _userContact;
  String _userAddress;

  final _formKey = GlobalKey<FormState>();

  // void _logout(BuildContext context) async {
  //   if (doesRun) {
  //     if (_auth.currentUser.providerData != null) {
  //       if (_auth.currentUser.providerData[0].providerId == 'google.com') {
  //         print('In If BLOCK');
  //         await GoogleSignIn().signOut();
  //       }
  //     }
  //     _auth.signOut();
  //     // Navigator.of(context).pushReplacementNamed(LoginScreen.loginScreen);
  //   }
  // }
  //
  // @override
  // void initState() {
  //   if (doesRun) {
  //     WidgetsBinding.instance.addObserver(this);
  //     super.initState();
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   if (doesRun) {
  //     WidgetsBinding.instance.removeObserver(this);
  //     super.dispose();
  //   }
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (doesRun) {
  //     final bool isBackground = state == AppLifecycleState.paused;
  //     if (isBackground) {
  //       print('IN IS CLOSED METHOG HELLO !@#');
  //       _logout(context);
  //     }
  //     super.didChangeAppLifecycleState(state);
  //   }
  // }

  void onSave() async {
    // if (_pickedImage == null) {
    //   await showDialog(
    //     context: context,
    //     builder: (ctx) {
    //       return GestureDetector(
    //         behavior: HitTestBehavior.opaque,
    //         child: AlertDialog(
    //           title: Text('Please Pick an image'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Text('Ok'),
    //             )
    //           ],
    //         ),
    //       );
    //     },
    //   );
    //   return;
    // }
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      setState(() {
        _isUploadingStarted = true;
      });
      String _userImageUrl;
      try {
        if (_pickedImage != null) {
          _userImageUrl = await UserDetailFromFilling.putUserImage(
            path1: 'users_image',
            path2: '$_currentUserUID.jpg',
            pickedImage: _pickedImage,
          );
          // final ref = _firebaseStorage
          //     .ref()
          //     .child('users_image')
          //     .child('$_currentUserUID.jpg');
          // await ref.putFile(_pickedImage).whenComplete(
          //   () async {
          //     _userImageUrl = await ref.getDownloadURL();
          //   },
          // );
        }
        await UserDetailFromFilling.createUserDoc(
          currentUserUID: _currentUserUID,
          userAddress: _userAddress,
          userContact: _userContact,
          userImageUrl: _pickedImage == null
              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1LCcfD_jjhno3IC7VwOHLv6KLNPAq_wfqzA&usqp=CAU'
              : _userImageUrl,
          userName: _userName,
        );
        // await _firestore.collection('users').doc(_currentUserUID).set(
        //   {
        //     'address': _userAddress,
        //     'contact': _userContact,
        //     'image': _userImageUrl,
        //     'name': _userName,
        //     'totalBookings': 0,
        //     'bookings': [],
        //   },
        // );

        setState(() {
          _isUploadingStarted = false;
        });
        Navigator.of(context)
            .pushReplacementNamed(CategoryScreen.categoryScreen);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void pickImage() {
    showDialog(
      context: context,
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                onWantToTakePic(ImageSource.camera);
              },
              child: Text(
                'Open Camera',
              ),
            ),
            SizedBox(height: 10),
            SimpleDialogOption(
              onPressed: () {
                onWantToTakePic(ImageSource.gallery);
              },
              child: Text(
                'Pick From Gallery',
              ),
            ),
            SizedBox(height: 10),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child: Text(
                'Cancel',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onWantToTakePic(ImageSource imageSource) async {
    final picker = ImagePicker();
    final image = await picker.getImage(
      source: imageSource,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (image == null) return;
    setState(() {
      _pickedImage = File(image.path);
    });
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _currentUserUID = ModalRoute.of(context).settings.arguments as String;
    print('HERE IS THE USER ID MODAL ROUTE : ' + _currentUserUID);
    return Scaffold(
      appBar: AppBar(
        title: Text('Please fill your details'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isUploadingStarted,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFF033249),
                    backgroundImage: _pickedImage == null
                        ? AssetImage('assets/images/image.png')
                        : FileImage(_pickedImage),
                  ),
                  TextButton.icon(
                    onPressed: pickImage,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: kdarkBlue,
                    ),
                    label: Text(
                      'Add photo',
                      style: TextStyle(color: kdarkBlue),
                    ),
                  ),
                  TextFormField(
                    key: ValueKey('name'),
                    keyboardType: TextInputType.name,
                    decoration: klogininput.copyWith(labelText: 'Name'),
                    validator: (value) {
                      if (value.length < 4) {
                        return 'Atleast 4 char long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('Contact'),
                    keyboardType: TextInputType.phone,
                    decoration: klogininput.copyWith(
                      labelText: 'Contact',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: kdarkBlue,
                      ),
                    ),
                    validator: (value) {
                      if (value.length < 10) {
                        return 'Provide right number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userContact = value;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('address'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: klogininput.copyWith(
                      labelText: 'Address',
                      prefixIcon: Icon(
                        Icons.home,
                        color: kdarkBlue,
                      ),
                    ),
                    validator: (value) {
                      if (value.length < 10) {
                        return 'Provide full address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userAddress = value;
                    },
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      doesRun = false;
                      onSave();
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
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
