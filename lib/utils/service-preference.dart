import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ServicePreference {
  // Login
  Future<bool> login() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.containsKey('access_token');
  }

  // Logout
  Future<void> logout() async {
    // Simulate a future for response after 1 second.
    return await new Future<void>.delayed(
      new Duration(
        seconds: 1
      )
    );
  }

  Future<String> getKeyer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().toString();
  }
}

class PrefService {
  Future<bool> onBoard() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.clear();
    return pref.containsKey('onboard');
  }
}