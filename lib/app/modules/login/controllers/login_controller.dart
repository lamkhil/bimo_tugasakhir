import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/data/user_service.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/global/widgets/loading.dart';
import 'package:tugasakhir/app/routes/app_pages.dart';

import '../../../../main.dart';
import '../../../data/model/user.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  login() async {
    if (formKey.currentState!.validate()) {
      try {
        LoadingDialog.basic();
        final result = await UserService.login(
            usernameController.text.toLowerCase(), passwordController.text);
        if (result != null) {
          Get.find<AppController>().user.value = result;
          Get.offAllNamed(Routes.BANDARA_FORM);
        }
      } catch (e) {
        Get.back();
        log(e.toString());
      }
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
