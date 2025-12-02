import 'package:design_system/gitit/gitit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);

  static SharedPreferences get _sharedPref => locator.get<SharedPreferences>();

  static Future<void> setDarkMode(bool isDark) async {
    await _sharedPref.setBool('isDarkMode', isDark);
  }
  
  static bool getDarkMode() {
    return _sharedPref.getBool('isDarkMode') ?? false;
  }

}