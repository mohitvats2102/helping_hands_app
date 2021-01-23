import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function({
    String email,
    String password,
    String username,
    bool islogin,
    BuildContext ctx,
  }) tryLoginUser;

  AuthForm(this.tryLoginUser);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _islogin = true;
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _username = '';
  String _password = '';

  void onSave() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();

      await widget.tryLoginUser(
        email: _email.trim(),
        password: _password.trim(),
        username: _username,
        islogin: _islogin,
        ctx: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                key: ValueKey('email'),
                keyboardType: TextInputType.emailAddress,
                decoration: klogininput,
                validator: (value) {
                  if (!value.contains('@')) {
                    return 'Please enter a valid e-mail address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 20),
              if (!_islogin)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    key: ValueKey('user'),
                    decoration: klogininput.copyWith(
                      hintText: 'username',
                      icon: Icon(
                        Icons.person_outline,
                        color: kdarkBlue,
                      ),
                    ),
                    validator: (value) {
                      if (value.length < 4) {
                        return 'Username must be 4 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value;
                    },
                  ),
                ),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                decoration: klogininput.copyWith(
                  hintText: 'password',
                  icon: Icon(
                    Icons.lock_outline,
                    color: kdarkBlue,
                  ),
                ),
                validator: (value) {
                  if (value.length < 8) {
                    return 'Password must be 8 charecters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  _islogin ? 'Login' : 'Register',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: onSave,
                color: kdarkBlue,
              ),
              SizedBox(height: _islogin ? 50 : 20),
              Text(
                _islogin
                    ? 'Don\'t have any account.'
                    : 'Already have an account.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kdarkBlue,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _islogin = !_islogin;
                  });
                },
                child: Text(
                  _islogin ? 'Register' : 'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kdarkBlue,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/logo.jpg'),
              )
            ],
          ),
        ),
      ),
    );
  }
}