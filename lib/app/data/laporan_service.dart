// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhir/app/data/user_service.dart';
import 'package:tugasakhir/app/modules/bandara_form/controllers/bandara_form_controller.dart';
import 'package:tugasakhir/app/routes/app_pages.dart';

class LaporanService {
  static Future<void> saveLaporan(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('$kelasBandara-$namaBandara')
        .doc(data['created_at'].toString().replaceAll('/', '-'))
        .set(data);
    UserService.addNotif('admin',
        'Laporan ${data['created_at'].toString().replaceAll('/', '-')} telah ditambahkan',
        arguments: {
          'navigate': Routes.TAMBAH_LAPORAN,
          'data': data['created_at'].toString().replaceAll('/', '-')
        });
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

    FirebaseFirestore.instance.collection('user').get().then((value) {
      for (var element in value.docs) {
        if (element.id != 'admin') {
          UserService.addNotif(element.id,
              'Laporan perbaikan  ${created_at.replaceAll('/', '-')} $key1 - ${key2.toLowerCase()} telah disetujui',
              arguments: {'tab': 0});
        }
      }
    });
  }

  static Future<void> accLaporanAll(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('$kelasBandara-$namaBandara')
        .doc(data['created_at'].toString().replaceAll('/', '-'))
        .set(data);

    FirebaseFirestore.instance.collection('user').get().then((value) {
      for (var element in value.docs) {
        if (element.id != 'admin') {
          UserService.addNotif('user',
              'Laporan rutin ${data['created_at'].toString().replaceAll('/', '-')} telah disetujui',
              arguments: {
                'navigate': Routes.TAMBAH_LAPORAN,
                'data': data['created_at'].toString().replaceAll('/', '-')
              });
        }
      }
    });
  }

  static Future<void> addFoto(
      String id, String key1, String key2, String image, bool newFoto) async {
    if (newFoto) {
      await FirebaseFirestore.instance
          .collection('$kelasBandara-$namaBandara')
          .doc(id)
          .set({
        key1: {
          key2: {
            'progress-image': [image]
          }
        }
      }, SetOptions(merge: true));
    } else {
      await FirebaseFirestore.instance
          .collection('$kelasBandara-$namaBandara')
          .doc(id)
          .set({
        key1: {
          key2: {
            'progress-image': FieldValue.arrayUnion([image])
          }
        }
      }, SetOptions(merge: true));
    }
  }
}
