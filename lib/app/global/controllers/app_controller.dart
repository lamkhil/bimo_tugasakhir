import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/data/model/user.dart';

import '../../data/laporan_service.dart';
import '../widgets/loading.dart';

class AppController extends GetxController {
  Rx<User?> user = Rx(null);

  Rx<QuerySnapshot<Map<String, dynamic>>?> data = Rx(null);

  Future<void> getData() async {
    final result = await LaporanService.getLaporan();
    data.value = result;
  }

  @override
  void onInit() {
    user.listen((p0) {
      print(p0?.notif);
    });
    super.onInit();
  }
}
