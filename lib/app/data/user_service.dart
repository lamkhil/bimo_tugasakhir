import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/data/model/user.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
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
      return User(
          nama: nama, password: password, username: username, notif: []);
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
      final user = User.fromMap(result.data()!);
      sharedPreferences.setString('user', json.encode(user.toMap()));
      return user;
    } else {
      return null;
    }
  }

  static Future<void> refresh() async {
    final result = await FirebaseFirestore.instance
        .collection('user')
        .doc(Get.find<AppController>().user.value!.username)
        .get();
    Get.find<AppController>().user.value = User.fromMap(result.data()!);
    sharedPreferences.setString(
        'user', json.encode(Get.find<AppController>().user.value!.toMap()));
    Get.find<AppController>().user.refresh();
  }

  static Future<void> addNotif(String to, String title) async {
    if ((await FirebaseFirestore.instance
            .collection('user')
            .doc(to.toLowerCase())
            .get())
        .exists) {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(to.toLowerCase())
          .update({
        "notif": FieldValue.arrayUnion([
          {'title': title, 'created_at': Timestamp.now()}
        ])
      });
    }
  }
}
