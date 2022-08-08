// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhir/app/data/user_service.dart';
import 'package:tugasakhir/app/modules/bandara_form/controllers/bandara_form_controller.dart';

class LaporanService {
  static Future<void> saveLaporan(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('$kelasBandara-$namaBandara')
        .doc(data['created_at'].toString().replaceAll('/', '-'))
        .set(data);
    UserService.addNotif('admin',
        'Laporan ${data['created_at'].toString().replaceAll('/', '-')} telah ditambahkan');
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getLaporan() async {
    return await FirebaseFirestore.instance
        .collection('$kelasBandara-$namaBandara')
        .get();
  }

  static Future<void> accLaporan(
      String created_at, String key1, String key2) async {
    await FirebaseFirestore.instance
        .collection('$kelasBandara-$namaBandara')
        .doc(created_at.replaceAll('/', '-'))
        .set({
      key1: {
        key2: {
          'accept': true,
          'accept_at': DateFormat('dd/MM/yyyy').format(DateTime.now())
        }
      }
    }, SetOptions(merge: true));

    UserService.addNotif('user',
        'Laporan perbaikan ${created_at.replaceAll('/', '-')} telah disetujui');
  }
}
