import 'package:get/get.dart';
import 'package:tugasakhir/app/modules/home/controllers/tab/laporan_controller.dart';
import 'package:tugasakhir/app/modules/home/controllers/tab/notifikasi_controller.dart';
import 'package:tugasakhir/app/modules/home/controllers/tab/perbaikan_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<PerbaikanController>(
      () => PerbaikanController(),
    );
    Get.lazyPut<LaporanController>(
      () => LaporanController(),
    );
    Get.lazyPut<NotifikasiController>(
      () => NotifikasiController(),
    );
  }
}
