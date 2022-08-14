import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/data/model/user.dart';
import 'package:tugasakhir/app/data/user_service.dart';

import '../../data/laporan_service.dart';
import '../widgets/loading.dart';

class AppController extends GetxController {
  Rx<User?> user = Rx(null);

  Rx<QuerySnapshot<Map<String, dynamic>>?> data = Rx(null);

  Future<void> getData() async {
    final result = await LaporanService.getLaporan();
    data.value = result;
    UserService.refresh();
  }
}
