import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/data/user_service.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class Notif extends StatelessWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Get.find<AppController>().user.value!.notif);
    return Obx(
      () => Column(
          mainAxisSize: MainAxisSize.max,
          children: Get.find<AppController>()
              .user
              .value!
              .notif
              .map((entry) => ListTile(
                    title: Text(entry['title']),
                    subtitle: Text(timeago.format(
                        (entry['created_at'] as Timestamp).toDate(),
                        locale: 'id')),
                  ))
              .toList()),
    );
  }
}
