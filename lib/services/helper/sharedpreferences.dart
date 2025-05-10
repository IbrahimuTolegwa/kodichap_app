// import 'package:shared_preferences/shared_preferences.dart';
//
// class sharedpreferences {
//   static const String keyName = 'userName';
//   static const String keyEmail = 'userName';
//   static const String loginKey = 'is_logged_in';
//
//   //saving username
//   Future<void> saveusername(String userName) async {
//      SharedPreferences sp = await SharedPreferences.getInstance();
//      await sp.setString(keyName, userName);
//   }
//   //getting username
//   Future<void> getusername() async{
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.get(keyName);
//   }
//
//
//   //saving email
//   Future<void> saveEmail(String email) async {
//      SharedPreferences sp = await SharedPreferences.getInstance();
//      await sp.setString(keyEmail, email);
//   }
//   //getting email
//   Future<void> getEmail() async{
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.get(keyEmail);
//   }
//
//
//   //saving login status
//   Future<void> saveloginStatus(bool loginStatus) async {
//      SharedPreferences sp = await SharedPreferences.getInstance();
//      await sp.setBool(loginKey, loginStatus);
//   }
//   //getting login status
//   Future<bool> getloginStatus(bool loginStatus) async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     return sp.getBool(loginKey) ?? false;
//   }
// }