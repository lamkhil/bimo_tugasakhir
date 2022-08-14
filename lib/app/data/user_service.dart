import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/data/model/user.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/main.dart';

class UserService {
  static Future<User?> register(
      String nama, String password, String username) async {
    if ((await FirebaseFirestore.instance
            .collection('user')
            .doc(username.toLowerCase())
            .get())
        .exists) {
      return null;
    } else {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(username.toLowerCase())
          .set({
        'nama': nama,
        'password': password,
        'username': username,
        'accept': false
      });
      addNotif('admin', "Registrasi pengguna ${username.toLowerCase()}",
          data: {'status': 'pending', 'user': username});
      return User(
          nama: nama,
          password: password,
          username: username,
          notif: [],
          accept: false);
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
      if (user.accept) {
        return user;
      } else {
        Get.back();
        Get.snackbar("Oops!",
            "Akun anda belum disetujui admin, hubungi admin untuk tindakan lebih lanjut",
            colorText: Colors.white, backgroundColor: Colors.red);
        return null;
      }
    } else {
      Get.back();
      Get.snackbar("Oops!", "Username / password salah",
          colorText: Colors.white, backgroundColor: Colors.red);
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

  static Future<void> updateUser(User user) async {
    var value = user.toMap();
    value['notif'] = user.notif.reversed.toList();
    await FirebaseFirestore.instance
        .collection('user')
        .doc(Get.find<AppController>().user.value!.username)
        .set(value);
  }

  static Future<void> accUser(String username) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(username)
        .update({'accept': true});
  }

  static Future<void> addNotif(String to, String title,
      {dynamic data, dynamic arguments}) async {
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
          {
            'title': title,
            'created_at': Timestamp.now(),
            'data': data,
            'arguments': arguments
          }
        ])
      });
    }
  }
}
