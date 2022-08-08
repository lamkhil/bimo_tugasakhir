import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/routes/app_pages.dart';

import '../../../data/user_service.dart';
import '../../../global/widgets/loading.dart';

String? kelasBandara;
String? namaBandara;

class BandaraFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final kelas = ["Kelas 1", "Kelas 2", "Kelas 3"];
  final bandara = [
    [""],
    ["Bandara Bianka"],
    [""]
  ];
  final Rx<int?> selectedKelas = Rx(null);
  final Rx<int?> selectedBandara = Rx(null);

  Future<void> lanjutkan() async {
    if (selectedKelas.value != null && selectedBandara.value != null) {
      UserService.refresh();
      kelasBandara = kelas[selectedKelas.value!];
      namaBandara = bandara[selectedKelas.value!][selectedBandara.value!];
      LoadingDialog.basic();
      await Get.find<AppController>().getData();
      Get.back();
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar("Oops!", "Kelas dan nama bandara tidak boleh kosong!");
    }
  }
}
