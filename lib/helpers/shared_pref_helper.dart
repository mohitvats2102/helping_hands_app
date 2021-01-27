import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _userNameKey = 'username';
  static const String _addressKey = 'address';
  static const String _contactKey = 'contact';

  Future<bool> setUserName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userNameKey, username);
  }

  Future<bool> setAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_addressKey, address);
  }

  Future<bool> setContact(String contact) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_contactKey, contact);
  }

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userNameKey);
  }

  Future<String> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_addressKey);
  }

  Future<String> getContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_contactKey);
  }
}
