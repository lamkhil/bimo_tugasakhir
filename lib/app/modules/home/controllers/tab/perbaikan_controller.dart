import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/global/widgets/loading.dart';
import 'package:tugasakhir/app/modules/home/views/tab/perbaikan/tab/done.dart';
import 'package:tugasakhir/app/modules/home/views/tab/perbaikan/tab/progress.dart';
import 'package:tugasakhir/app/modules/home/views/tab/perbaikan/tab/reported.dart';

class PerbaikanController extends GetxController {
  final tabTextIndexSelected = 0.obs;

  var listTextTabToggle = ["Reported", "In Progress", "Done"];
  RxList<Map<String, dynamic>> reported = RxList([]);
  RxList<Map<String, dynamic>> inProgress = RxList([]);
  RxList<Map<String, dynamic>> done = RxList([]);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    await Get.find<AppController>().getData();
    reported.clear();
    inProgress.clear();
    done.clear();
    for (var element in Get.find<AppController>().data.value!.docs) {
      element.data().forEach((key, value) {
        if (value is Map) {
          value.forEach((key2, value2) {
            if (value2['status'] == 'rusak') {
              if (value2['accept'] == null) {
                reported.add({
                  'title': key,
                  'data': {'title': key2, 'data': value2},
                  'created_at': element.data()['created_at']
                });
              } else {
                DateTime created =
                    DateFormat('dd/MM/yyyy').parse(value2['accept_at']);
                int waktu = int.parse(value2['waktuPerbaikan'].split(' ')[0]);
                if (created
                    .add(Duration(days: waktu))
                    .isAfter(DateTime.now())) {
                  inProgress.add({
                    'title': key,
                    'data': {'title': key2, 'data': value2},
                    'created_at': element.data()['created_at']
                  });
                } else {
                  done.add({
                    'title': key,
                    'data': {'title': key2, 'data': value2},
                    'created_at': element.data()['created_at']
                  });
                }
              }
            }
          });
        }
      });
    }
  }

  var listTextSelectedToggle = [
    const ReportedTab(),
    const ProgressTab(),
    const DoneTab()
  ];
}
