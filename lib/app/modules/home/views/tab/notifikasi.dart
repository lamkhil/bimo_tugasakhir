import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/data/user_service.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tugasakhir/app/modules/home/controllers/home_controller.dart';

class Notif extends StatelessWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: Get.find<AppController>().getData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Obx(
          () => Column(
              mainAxisSize: MainAxisSize.max,
              children:
                  Get.find<AppController>().user.value!.notif.map((entry) {
                if (entry['data'] != null) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(entry['title']),
                        subtitle: Text(timeago.format(
                            (entry['created_at'] as Timestamp).toDate(),
                            locale: 'id')),
                      ),
                      entry['data']['status'] != 'pending'
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    "Menolak pendaftaran",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: const Text(
                                                      "Apakah anda yakin ingin menolak pendaftaran ini?"),
                                                  actions: [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            primary:
                                                                Colors.white,
                                                            side: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text(
                                                          "Tidak",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          int index = Get.find<
                                                                  AppController>()
                                                              .user
                                                              .value!
                                                              .notif
                                                              .indexOf(entry);
                                                          Get.find<AppController>()
                                                                      .user
                                                                      .value!
                                                                      .notif[
                                                                  index]['data']
                                                              [
                                                              'status'] = 'done';

                                                          Get.find<AppController>()
                                                                  .user
                                                                  .value!
                                                                  .notif[index]
                                                              ['title'] = entry[
                                                                  'title'] +
                                                              " ditolak";
                                                          UserService.updateUser(
                                                              Get.find<
                                                                      AppController>()
                                                                  .user
                                                                  .value!);
                                                          Get.find<
                                                                  AppController>()
                                                              .user
                                                              .refresh();
                                                          Get.back();
                                                          Get.snackbar(
                                                              "Success!",
                                                              "Berhasil menolak pendaftaran ${entry['data']['user']}");
                                                        },
                                                        child:
                                                            const Text("Iya")),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Text(
                                          "Tolak",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    "Menyetujui pendaftaran",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: const Text(
                                                      "Apakah anda yakin ingin menyetujui pendaftaran ini?"),
                                                  actions: [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            primary:
                                                                Colors.white,
                                                            side: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text(
                                                          "Tidak",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          int index = Get.find<
                                                                  AppController>()
                                                              .user
                                                              .value!
                                                              .notif
                                                              .indexOf(entry);
                                                          Get.find<AppController>()
                                                                      .user
                                                                      .value!
                                                                      .notif[
                                                                  index]['data']
                                                              [
                                                              'status'] = 'done';

                                                          Get.find<AppController>()
                                                                  .user
                                                                  .value!
                                                                  .notif[index]
                                                              ['title'] = entry[
                                                                  'title'] +
                                                              " diterima";
                                                          Get.find<
                                                                  AppController>()
                                                              .user
                                                              .refresh();
                                                          UserService.updateUser(
                                                              Get.find<
                                                                      AppController>()
                                                                  .user
                                                                  .value!);
                                                          UserService.accUser(
                                                              entry['data']
                                                                  ['user']);
                                                          Get.back();
                                                          Get.snackbar(
                                                              "Success!",
                                                              "Berhasil menyetujui pendaftaran ${entry['data']['user']}");
                                                        },
                                                        child:
                                                            const Text("Iya")),
                                                  ],
                                                );
                                              });
                                        },
                                        child: const Text("Setujui")),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  );
                }
                return ListTile(
                  onTap: () {
                    if (entry['arguments']['navigate'] != null) {
                      Get.toNamed(entry['arguments']['navigate'],
                          arguments: Get.find<AppController>()
                              .data
                              .value!
                              .docs
                              .where((element) =>
                                  element.id == entry['arguments']['data'])
                              .first
                              .data());
                    } else {
                      Get.find<HomeController>().screenIndex.value =
                          entry['arguments']['tab'] ?? 0;
                    }
                  },
                  title: Text(entry['title']),
                  subtitle: Text(timeago.format(
                      (entry['created_at'] as Timestamp).toDate(),
                      locale: 'id')),
                );
              }).toList()),
        ),
      ),
    );
  }
}
