import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import '../routes/app_pages.dart';

final kToday = DateTime.now();
// final Arr = [kToday, kTomorrow];
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

Future<bool> requestPermission(Permission p) async {
  if (await p.isGranted) {
    return true;
  } else {
    var result = await p.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}

final drawer = Drawer(
  child: SafeArea(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(15, 20, 0, 20),
          alignment: Alignment.centerLeft,
          child: const Icon(
            Icons.account_circle,
            size: 50,
            color: Colors.grey,
          ),
        ),
        ListTile(
          dense: true,
          visualDensity: VisualDensity(vertical: -4),
          title: const Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          onTap: () {
            if (Get.currentRoute != Routes.HOME) {
              Get.offNamed(Routes.HOME);
            }
          },
        ),
        ListTile(
          dense: true,
          visualDensity: VisualDensity(vertical: -4),
          title: const Text(
            'Analisa',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          onTap: () {
            if (Get.currentRoute != Routes.ANALISA) {
              Get.offNamed(Routes.ANALISA);
            }
          },
        ),
        ListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -4),
          title: const Text(
            'Sign Out',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          onTap: () {
            Get.offAllNamed(Routes.LOGIN);
            sharedPreferences.remove('user');
          },
        ),
        Expanded(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                )),
                child: ListTile(
                  onTap: () {
                    Get.back();
                  },
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -4),
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text(
                    'Kembali',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              )),
        ),
      ],
    ),
  ),
);
