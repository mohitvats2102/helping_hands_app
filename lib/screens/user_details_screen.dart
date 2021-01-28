import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helping_hands_app/constant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../widget/base_ui.dart';

class UserDetailScreen extends StatefulWidget {
  static const String userDetailScreen = '/user_detail_screen';

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, String> routeArgs;
  bool _isInit = true;
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _address;
  String _contact;
  bool _isRegisterStart = false;

  void _trySavingForm() async {
    bool _isValid = _formKey.currentState.validate();
    if (_isValid) {
      _formKey.currentState.save();
      setState(() {
        _isRegisterStart = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: routeArgs['email'], password: routeArgs['password']);
        await _firestore.collection('users').doc(routeArgs['email']).set({
          'name': _userName,
          'address': _address,
          'contact': _contact,
        });
        setState(() {
          _isRegisterStart = false;
        });
        Navigator.of(context).pop(true);
      } catch (e) {
        setState(() {
          _isRegisterStart = false;
        });
        Navigator.of(context).pop(e.message);
      }
    } else {
      return;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _userName = routeArgs['username'];
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ModalProgressHUD(
        inAsyncCall: _isRegisterStart,
        child: SafeArea(
          child: BaseUI(
            text1: 'Welcome',
            text2: _userName,
            fontsize: 45,
            fontWeight: FontWeight.bold,
            padding: const EdgeInsets.only(left: 18, top: 0),
            height: 50,
            radius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _userName,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: kdarkBlue),
                          border: OutlineInputBorder(),
                          labelText: 'Your Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home_filled, color: kdarkBlue),
                          border: OutlineInputBorder(),
                          labelText: 'Your Address',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid Address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _address = value;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: kdarkBlue),
                          border: OutlineInputBorder(),
                          labelText: 'Your Contact No.',
                        ),
                        validator: (value) {
                          if (value.length != 10) {
                            return 'Please enter valid number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _contact = value;
                        },
                      ),
                      SizedBox(height: 40),
                      RaisedButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _trySavingForm();
                        }, //_trySavingForm,
                        color: kdarkBlue,
                        textColor: Colors.white,
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
