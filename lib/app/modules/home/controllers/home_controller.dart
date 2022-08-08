import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/modules/home/views/tab/laporan.dart';
import 'package:tugasakhir/app/modules/home/views/tab/notifikasi.dart';
import 'package:tugasakhir/app/modules/home/views/tab/perbaikan/perbaikan.dart';

class HomeController extends GetxController {
  final screenIndex = 1.obs;
  final title = [
    'Perbaikan',
    'Laporan',
    'Notifikasi',
  ];
  final screen = [const PerbaikanTab(), const LaporanTab(), const Notif()];
  final drawerTitle = "".obs;
  Rx<Widget?> screenDrawer = Rx(null);

  final RxList<FlSpot> data1 = <FlSpot>[].obs;
  final RxList<FlSpot> data2 = <FlSpot>[].obs;
  final RxList<FlSpot> data3 = <FlSpot>[].obs;
  final RxList<FlSpot> data4 = <FlSpot>[].obs;
  final RxList<FlSpot> data5 = <FlSpot>[].obs;
  final RxList<FlSpot> data6 = <FlSpot>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getData() {
    getData1();
    getData2();
    getData3();
    getData4();
    getData5();
    getData6();
  }

  getData1() {
    data1.clear();
    for (var i = 0; i < 12; i++) {
      double avgData = 0;
      int sum = 0;
      int n = 0;
      for (var element in Get.find<AppController>().data.value!.docs) {
        if (element.data()['created_at'].toString().split('/')[1] ==
            DateFormat('dd/MM/yyyy')
                .format(DateTime(DateTime.now().year, DateTime.now().month - i))
                .split('/')[1]) {
          element.data().forEach((key, value) {
            if (key == 'taxiway') {
              if (value is Map) {
                value.forEach((key2, value2) {
                  if (value2['status'] == 'rusak') {
                    if (value2['levelKerusakan'] == "Ringan") {
                      sum += 1;
                    }
                    if (value2['levelKerusakan'] == "Sedang") {
                      sum += 2;
                    }
                    if (value2['levelKerusakan'] == "Berat") {
                      sum += 3;
                    }
                    n++;
                  }
                });
              }
            }
          });
        }
      }
      if (sum < 1) {
        avgData = 0;
      } else {
        avgData = sum / n;
      }
      data1.add(FlSpot((11 - i).toDouble(), avgData.ceilToDouble()));
    }
  }

  getData2() {
    data2.clear();
    for (var i = 0; i < 12; i++) {
      double avgData = 0;
      int sum = 0;
      int n = 0;
      for (var element in Get.find<AppController>().data.value!.docs) {
        if (element.data()['created_at'].toString().split('/')[1] ==
            DateFormat('dd/MM/yyyy')
                .format(DateTime(DateTime.now().year, DateTime.now().month - i))
                .split('/')[1]) {
          element.data().forEach((key, value) {
            if (key == 'drainase') {
              if (value is Map) {
                value.forEach((key2, value2) {
                  if (value2['status'] == 'rusak') {
                    if (value2['levelKerusakan'] == "Ringan") {
                      sum += 1;
                    }
                    if (value2['levelKerusakan'] == "Sedang") {
                      sum += 2;
                    }
                    if (value2['levelKerusakan'] == "Berat") {
                      sum += 3;
                    }
                    n++;
                  }
                });
              }
            }
          });
        }
      }
      if (sum < 1) {
        avgData = 0;
      } else {
        avgData = sum / n;
      }
      data2.add(FlSpot((11 - i).toDouble(), avgData.ceilToDouble()));
    }
  }

  getData3() {
    data3.clear();
    for (var i = 0; i < 12; i++) {
      double avgData = 0;
      int sum = 0;
      int n = 0;
      for (var element in Get.find<AppController>().data.value!.docs) {
        if (element.data()['created_at'].toString().split('/')[1] ==
            DateFormat('dd/MM/yyyy')
                .format(DateTime(DateTime.now().year, DateTime.now().month - i))
                .split('/')[1]) {
          element.data().forEach((key, value) {
            if (key == 'pagarPerimeter') {
              if (value is Map) {
                value.forEach((key2, value2) {
                  if (value2['status'] == 'rusak') {
                    if (value2['levelKerusakan'] == "Ringan") {
                      sum += 1;
                    }
                    if (value2['levelKerusakan'] == "Sedang") {
                      sum += 2;
                    }
                    if (value2['levelKerusakan'] == "Berat") {
                      sum += 3;
                    }
                    n++;
                  }
                });
              }
            }
          });
        }
      }
      if (sum < 1) {
        avgData = 0;
      } else {
        avgData = sum / n;
      }
      data3.add(FlSpot((11 - i).toDouble(), avgData.ceilToDouble()));
    }
  }

  getData4() {
    data4.clear();
    for (var i = 0; i < 12; i++) {
      double avgData = 0;
      int sum = 0;
      int n = 0;
      for (var element in Get.find<AppController>().data.value!.docs) {
        if (element.data()['created_at'].toString().split('/')[1] ==
            DateFormat('dd/MM/yyyy')
                .format(DateTime(DateTime.now().year, DateTime.now().month - i))
                .split('/')[1]) {
          element.data().forEach((key, value) {
            if (key == 'runway') {
              if (value is Map) {
                value.forEach((key2, value2) {
                  if (value2['status'] == 'rusak') {
                    if (value2['levelKerusakan'] == "Ringan") {
                      sum += 1;
                    }
                    if (value2['levelKerusakan'] == "Sedang") {
                      sum += 2;
                    }
                    if (value2['levelKerusakan'] == "Berat") {
                      sum += 3;
                    }
                    n++;
                  }
                });
              }
            }
          });
        }
      }
      if (sum < 1) {
        avgData = 0;
      } else {
        avgData = sum / n;
      }
      data4.add(FlSpot((11 - i).toDouble(), avgData.ceilToDouble()));
    }
  }

  getData5() {
    data5.clear();
    for (var i = 0; i < 12; i++) {
      double avgData = 0;
      int sum = 0;
      int n = 0;
      for (var element in Get.find<AppController>().data.value!.docs) {
        if (element.data()['created_at'].toString().split('/')[1] ==
            DateFormat('dd/MM/yyyy')
                .format(DateTime(DateTime.now().year, DateTime.now().month - i))
                .split('/')[1]) {
          element.data().forEach((key, value) {
            if (key == 'apron') {
              if (value is Map) {
                value.forEach((key2, value2) {
                  if (value2['status'] == 'rusak') {
                    if (value2['levelKerusakan'] == "Ringan") {
                      sum += 1;
                    }
                    if (value2['levelKerusakan'] == "Sedang") {
                      sum += 2;
                    }
                    if (value2['levelKerusakan'] == "Berat") {
                      sum += 3;
                    }
                    n++;
                  }
                });
              }
            }
          });
        }
      }
      if (sum < 1) {
        avgData = 0;
      } else {
        avgData = sum / n;
      }
      data5.add(FlSpot((11 - i).toDouble(), avgData.ceilToDouble()));
    }
  }

  getData6() {
    data6.clear();
    for (var i = 0; i < 12; i++) {
      double avgData = 0;
      int sum = 0;
      int n = 0;
      for (var element in Get.find<AppController>().data.value!.docs) {
        if (element.data()['created_at'].toString().split('/')[1] ==
            DateFormat('dd/MM/yyyy')
                .format(DateTime(DateTime.now().year, DateTime.now().month - i))
                .split('/')[1]) {
          log(element.data().toString());
          element.data().forEach((key, value) {
            if (key == 'runwayStrip') {
              if (value is Map) {
                value.forEach((key2, value2) {
                  if (value2['status'] == 'rusak') {
                    if (value2['levelKerusakan'] == "Ringan") {
                      sum += 1;
                    }
                    if (value2['levelKerusakan'] == "Sedang") {
                      sum += 2;
                    }
                    if (value2['levelKerusakan'] == "Berat") {
                      sum += 3;
                    }
                    n++;
                  }
                });
              }
            }
          });
        }
      }
      if (sum < 1) {
        avgData = 0;
      } else {
        avgData = sum / n;
      }
      data6.add(FlSpot((11 - i).toDouble(), avgData.ceilToDouble()));
    }
  }
}
