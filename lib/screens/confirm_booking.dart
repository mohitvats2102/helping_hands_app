import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../helpers/shared_pref_helper.dart';
import '../widget/base_ui.dart';

class BookingScreen extends StatefulWidget {
  static const String bookingPageRoute = '/booking_screen';

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  SharedPrefHelper _pref = SharedPrefHelper();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  bool _isBookingStart = false;

  DateTime _pickedDate;
  TimeOfDay _pickedTime;
  String _name = '';
  String _address = '';
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      setState(() {
        getUserName();
      });
    }
  }

  void getUserName() async {
    _name = await _pref.getUserName();
    _address = await _pref.getAddress();
    _phoneNumber = await _pref.getContact();

    _nameController.text = _name;
    _addressController.text = _address;
    _contactController.text = _phoneNumber;
  }

  @override
  void dispose() {
    super.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _nameController.dispose();
  }

  void _trySavingForm() async {
    bool _isValid = _formKey.currentState.validate();
    if (_isValid) {
      _formKey.currentState.save();
    } else {
      return;
    }
    FocusScope.of(context).unfocus();
    if (_pickedDate == null || _pickedTime == null) {
      String _msg;
      if (_pickedDate == null && _pickedTime == null)
        _msg = 'Please Choose Date and Time';
      else if (_pickedTime == null)
        _msg = 'Please Choose a Time';
      else if (_pickedDate == null) _msg = 'Please Choose a Date';
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(_msg),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          );
        },
      );
    } else {
      setState(() {
        _isBookingStart = true;
      });
      await _tryConfirmBooking();
      setState(() {
        _isBookingStart = false;
      });
      await showDialog(
        context: context,
        builder: (ctx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: SimpleDialog(
              titlePadding: const EdgeInsets.all(20),
              title: Text('Your Booking is Confirmed'),
              children: [
                SimpleDialogOption(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _tryConfirmBooking() async {
    Duration dummyDelay = Duration(seconds: 2);
    await Future.delayed(dummyDelay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ModalProgressHUD(
        inAsyncCall: _isBookingStart,
        child: SafeArea(
          child: BaseUI(
            text1: 'Confirm Your',
            text2: 'Booking',
            fontsize: 40,
            fontWeight: FontWeight.bold,
            padding: const EdgeInsets.only(left: 18),
            height: 30,
            radius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 10),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
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
                          _name = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _addressController,
                        maxLines: 2,
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
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _contactController,
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
                          _phoneNumber = value;
                        },
                      ),
                      SizedBox(height: 20),
                      ChooseDateOrTime(
                        endText: _pickedDate == null
                            ? 'No Date Choosen'
                            : DateFormat.yMd().format(_pickedDate),
                        iconText: _pickedDate == null
                            ? 'Choose a Date'
                            : 'Edit Choosen Date',
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              Duration(
                                days: 7,
                              ),
                            ),
                          ).then((value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _pickedDate = value;
                            });
                          });
                        },
                      ),
                      ChooseDateOrTime(
                        iconText: _pickedTime == null
                            ? 'Choose a Time'
                            : 'Edit Choosen Time',
                        endText: _pickedTime == null
                            ? 'No time Choosen'
                            : _pickedTime.format(context).toString(),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _pickedTime = value;
                            });
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: _trySavingForm,
                        color: kdarkBlue,
                        textColor: Colors.white,
                        child: Text(
                          'Confirm Booking',
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

class ChooseDateOrTime extends StatelessWidget {
  final String iconText;
  final String endText;
  final Function onTap;

  ChooseDateOrTime({
    this.endText,
    this.iconText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          onPressed: onTap,
          child: Text(
            iconText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: kdarkBlue,
            ),
          ),
        ),
        Text(
          endText,
          style: TextStyle(
            fontSize: 17,
            color: kdarkBlue,
          ),
        ),
      ],
    );
  }
}
