// import 'dart:convert';
// import 'package:flutter/material.dart';

// import '../../model/user/user_model.dart';
// import '../storage/local_storage.dart';

// class SessionController {
//   static final SessionController _session = SessionController._internal();

//   final LocalStorage localStorage = LocalStorage();

//   UserModel user = UserModel();
//   bool isLogin = false;

//   SessionController._internal();

//   factory SessionController() {
//     return _session;
//   }

//   /// ✅ SAVE USER SESSION
//   Future<void> saveUserInPreference(UserModel userModel) async {
//     try {
//       await localStorage.setValue('user', jsonEncode(userModel.toJson()));
//       await localStorage.setValue('isLogin', 'true');

//       /// update memory state also
//       user = userModel;
//       isLogin = true;
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   /// ✅ LOAD USER SESSION
//   Future<void> getUserFromPreference() async {
//     try {
//       final userData = await localStorage.readValue('user');
//       final loginFlag = await localStorage.readValue('isLogin');

//       if (userData != null && userData.isNotEmpty) {
//         user = UserModel.fromJson(jsonDecode(userData));
//       }

//       isLogin = loginFlag == 'true';
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   /// ✅ LOGOUT (BONUS)
//   Future<void> clearSession() async {
//     await localStorage.clearValue('user');
//     await localStorage.clearValue('isLogin');

//     user = UserModel();
//     isLogin = false;
//   }
// }
