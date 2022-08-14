import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/global/widgets/loading.dart';
import 'package:tugasakhir/app/modules/home/views/tab/perbaikan/tab/done.dart';
import 'package:tugasakhir/app/modules/home/views/tab/perbaikan/tab/progress.dart';
import 'package:tugasakhir/app/modules/home/views/tab/perbaikan/tab/reported.dart';

class PerbaikanController extends GetxController {
  final tabTextIndexSelected = 0.obs;
  ImagePicker picker = ImagePicker();

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
      if (element.data()['accept']) {
        element.data().forEach((key, value) {
          if (value is Map) {
            value.forEach((key2, value2) {
              if (value2['status'] == 'rusak') {
                if (value2['accept'] == null) {
                  reported.add({
                    'id': element.id,
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
                      'id': element.id,
                      'title': key,
                      'data': {'title': key2, 'data': value2},
                      'created_at': element.data()['created_at']
                    });
                  } else {
                    done.add({
                      'id': element.id,
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
  }

  Future<String?> pickCameraImage(String e, String cat) async {
    final result = await picker.pickImage(source: ImageSource.camera);
    if (result != null) {
      try {
        final date = DateFormat('ss-dd-MM-yyyy').format(DateTime.now());
        await FirebaseStorage.instance
            .ref()
            .child(
                'laporan/progress-$cat-$e-$date.${result.path.split('.').last}')
            .putFile(
                File(result.path),
                SettableMetadata(
                  contentType: "image/jpeg",
                ));
        return await FirebaseStorage.instance
            .ref()
            .child(
                'laporan/progress-$cat-$e-$date.${result.path.split('.').last}')
            .getDownloadURL();
      } on FirebaseException catch (e) {
        Get.back();
        Get.snackbar("Oops!", e.toString());
        return null;
      }
    }
    return null;
  }

  var listTextSelectedToggle = [
    const ReportedTab(),
    const ProgressTab(),
    const DoneTab()
  ];
}
