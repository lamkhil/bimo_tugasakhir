import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/modules/home/controllers/tab/perbaikan_controller.dart';

class PerbaikanTab extends GetView<PerbaikanController> {
  const PerbaikanTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.getData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 24.h,
            ),
            Center(
              child: Obx(
                () => FlutterToggleTab(
                  // width in percent
                  width: 90,
                  borderRadius: 5,
                  height: 30,
                  selectedIndex: controller.tabTextIndexSelected.value,
                  selectedBackgroundColors: const [Colors.grey, Colors.grey],
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                  unSelectedTextStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  labels: controller.listTextTabToggle,
                  selectedLabelIndex: (index) {
                    controller.tabTextIndexSelected.value = index;
                  },
                  isScroll: false,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Obx(() => controller
                .listTextSelectedToggle[controller.tabTextIndexSelected.value]),
          ],
        ),
      ),
    );
  }
}
