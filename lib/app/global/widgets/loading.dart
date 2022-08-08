import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog {
  static basic() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => SafeArea(
                child: Center(
              child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r)),
                  child: const CircularProgressIndicator()),
            )));
  }
}
