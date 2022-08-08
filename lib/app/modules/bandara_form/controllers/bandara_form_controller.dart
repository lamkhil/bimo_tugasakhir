import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/routes/app_pages.dart';

import '../../../global/widgets/loading.dart';

String? kelasBandara;
String? namaBandara;

class BandaraFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final kelasBandaraController = TextEditingController();
  final namaBandaraController = TextEditingController();

  Future<void> lanjutkan() async {
    if (formKey.currentState!.validate()) {
      kelasBandara =
          kelasBandaraController.text.toLowerCase().removeAllWhitespace;
      namaBandara =
          namaBandaraController.text.toLowerCase().removeAllWhitespace;
      LoadingDialog.basic();
      await Get.find<AppController>().getData();
      Get.back();
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void dispose() {
    kelasBandaraController.dispose();
    namaBandaraController.dispose();
    super.dispose();
  }
}
