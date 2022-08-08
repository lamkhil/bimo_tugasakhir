import 'package:get/get.dart';

import '../controllers/tambah_laporan_controller.dart';

class TambahLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahLaporanController>(
      () => TambahLaporanController(),
    );
  }
}
