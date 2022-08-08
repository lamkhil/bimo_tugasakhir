import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugasakhir/app/data/model/user.dart';
import 'package:tugasakhir/main.dart';

class UserService {
  static Future<User?> register(
      String nama, String password, String username) async {
    if ((await FirebaseFirestore.instance
            .collection('user')
            .doc(username)
            .get())
        .exists) {
      return null;
    } else {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(username)
          .set({'nama': nama, 'password': password, 'username': username});
      return User(nama: nama, password: password, username: username);
    }
  }

  static Future<User?> login(String username, String password) async {
    if ((await FirebaseFirestore.instance
            .collection('user')
            .doc(username.toLowerCase())
            .get())
        .exists) {
      final result = await FirebaseFirestore.instance
          .collection('user')
          .doc(username.toLowerCase())
          .get();
      sharedPreferences.setString('user', json.encode(result.data()!));
      return User.fromMap(result.data()!);
    } else {
      return null;
    }
  }
}
