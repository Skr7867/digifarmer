import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../storage/local_storage.dart';
import 'session_user_model.dart';

class SessionController {
  static final SessionController _session = SessionController._internal();

  final LocalStorage localStorage = LocalStorage();

  SessionUserModel? user;
  bool isLogin = false;

  SessionController._internal();

  factory SessionController() {
    return _session;
  }

  /// ✅ SAVE SESSION
  Future<void> saveUserInPreference(SessionUserModel userModel) async {
    try {
      await localStorage.setValue('user', jsonEncode(userModel.toJson()));
      await localStorage.setValue('isLogin', 'true');

      user = userModel;
      isLogin = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// ✅ LOAD SESSION
  Future<void> getUserFromPreference() async {
    try {
      final userData = await localStorage.readValue('user');
      final loginFlag = await localStorage.readValue('isLogin');

      if (userData != null && userData.isNotEmpty) {
        user = SessionUserModel.fromJson(jsonDecode(userData));
        log("SAVED TOKEN => ${user?.accessToken}");
        log("USER ROLE => ${user?.role}");
      }

      isLogin = loginFlag == 'true';
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// ✅ LOGOUT
  Future<void> clearSession() async {
    await localStorage.clearValue('user');
    await localStorage.clearValue('isLogin');

    user = null;
    isLogin = false;
  }
}
