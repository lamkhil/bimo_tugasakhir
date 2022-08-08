import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/data/user_service.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/global/widgets/loading.dart';
import 'package:tugasakhir/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      try {
        LoadingDialog.basic();
        final result = await UserService.register(namaController.text,
            passwordController.text, usernameController.text.toLowerCase());
        if (result != null) {
          Get.back();
          Get.snackbar("Sukses!", "Berhasil Registrasi");
        } else {
          Get.back();
          Get.snackbar(
              "Oops!", "Sudah terdapat username ${usernameController.text}");
        }
      } catch (e) {
        Get.back();
        log(e.toString());
      }
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
