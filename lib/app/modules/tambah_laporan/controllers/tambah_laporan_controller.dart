import 'dart:developer';
import 'dart:io';

import 'package:better_open_file/better_open_file.dart';
import 'package:excel/excel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugasakhir/app/data/laporan_service.dart';
import 'package:tugasakhir/app/global/const.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/global/widgets/loading.dart';
import 'package:tugasakhir/app/modules/tambah_laporan/controllers/pdf.dart';

import '../../../data/model/laporan.dart';
import '../../bandara_form/controllers/bandara_form_controller.dart';

class TambahLaporanController extends GetxController {
  final arguments = Get.arguments;

  final formKey = GlobalKey<FormState>();

  RxMap<String, dynamic> data = <String, dynamic>{}.obs;
  ImagePicker picker = ImagePicker();
  final petugasController = TextEditingController();

  final cuacaController = TextEditingController();

  void pickCameraImage(String e, String cat) async {
    final result = await picker.pickImage(source: ImageSource.camera);
    if (result != null) {
      try {
        LoadingDialog.basic();
        final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
        await FirebaseStorage.instance
            .ref()
            .child('laporan/$cat-$e-$date.${result.path.split('.').last}')
            .putFile(
                File(result.path),
                SettableMetadata(
                  contentType: "image/jpeg",
                ));
        data[cat][e]['image'] = await FirebaseStorage.instance
            .ref()
            .child('laporan/$cat-$e-$date.${result.path.split('.').last}')
            .getDownloadURL();
        Get.back();
        data.refresh();
      } on FirebaseException catch (e) {
        Get.back();
        Get.snackbar("Oops!", e.toString());
      }
    }
  }

  @override
  void onInit() {
    data['runway'] = {
      for (var value in runway) value: {'status': 'baik'}
    };
    data['taxiway'] = {
      for (var value in taxiway) value: {'status': 'baik'}
    };
    data['apron'] = {
      for (var value in apron) value: {'status': 'baik'}
    };
    data['runwayStrip'] = {
      for (var value in runwayStrip) value: {'status': 'baik'}
    };
    data['drainase'] = {
      for (var value in drainase) value: {'status': 'baik'}
    };
    data['pagarPerimeter'] = {
      for (var value in pagarPerimeter) value: {'status': 'baik'}
    };
    if (arguments != null) {
      petugasController.text = arguments['petugas'] ?? '';
      cuacaController.text = arguments['cuaca'] ?? '';
      data.addAll(arguments);
    }

    data['created_at'] = arguments == null
        ? DateFormat('dd/MM/yyyy').format(DateTime.now())
        : arguments['created_at'];
    super.onInit();
  }

  final jenisKerusakan = [
    'Retak memanjang',
    'Retak kulit buaya',
    'Retak setempat',
    'Retak melengkung',
    'Retak cermin',
    'Lepas atau Terurai',
    'Lubang',
    'Mengelupas',
    'Erosi akibat jetblast',
    'Kerusakan pada tepi patching',
    'Retak rambut',
    'Penurunan permukaan jalur roda',
    'Permukaan menggulung',
    'Penurunan setempat',
    'Permukaan bergelombang',
    'Agregat yang aus',
    'Kontaminasi Minyak',
    'Keluarnya material ke aspal'
  ];

  final tindakan = ['Patching'];

  final waktuPerbaikan = [
    "1 hari",
    "2 hari",
    "3 hari",
    "4 hari",
    "5 hari",
    "6 hari",
    "7 hari",
    "8 hari",
    "9 hari",
    "10 hari",
    "11 hari",
    "12 hari",
    "13 hari",
    "14 hari",
    "15 hari",
    "16 hari",
    "17 hari",
    "18 hari",
    "19 hari",
    "20 hari",
    "21 hari",
    "22 hari",
    "23 hari",
    "24 hari",
    "25 hari",
    "26 hari",
    "27 hari",
    "28 hari",
    "29 hari",
    "30 hari",
  ];

  final levelKerusakan = ["Ringan", "Sedang", "Berat"];

  Future<void> simpan() async {
    if (formKey.currentState!.validate()) {
      try {
        LoadingDialog.basic();
        data['petugas'] = petugasController.text;
        data['cuaca'] = cuacaController.text;
        data['accept'] = false;
        await LaporanService.saveLaporan(data);
        await Get.find<AppController>().getData();
        Get.back();
        Get.back();
      } catch (e) {
        Get.back();
        Get.snackbar("Oops!", e.toString());
      }
    }
  }

  Future<void> cetak() async {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: 150.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r))),
      padding: EdgeInsets.all(12.r),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.table_view),
            title: const Text("Cetak excel"),
            onTap: () async {
              Get.back();
              await excel();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text("Cetak pdf"),
            onTap: () async {
              Get.back();
              await pdf();
            },
          ),
        ],
      ),
    ));
  }

  Future<void> excel() async {
    var column = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];
    var directory = Directory('');
    final date = DateFormat('dd/MM/yyyy').parse(data['created_at']);
    String label = "$kelasBandara-$namaBandara ${data['created_at']}";
    // automatically creates 1 empty sheet: Sheet1
    var excel = Excel.createExcel();
    Sheet r = excel['Sheet1'];
    r.merge(CellIndex.indexByString("A1"), CellIndex.indexByString("B1"),
        customValue:
            "Hari/Tanggal: ${DateFormat('EEE/dd-MM-yyyy').format(date)}");
    r.merge(CellIndex.indexByString("A2"), CellIndex.indexByString("B2"),
        customValue: "Jam: ${DateFormat('hh:mm:ss').format(date)}");
    r.merge(CellIndex.indexByString("C1"), CellIndex.indexByString("D1"),
        customValue: "Cuaca: ${cuacaController.text}");
    r.merge(CellIndex.indexByString("C2"), CellIndex.indexByString("D2"),
        customValue: "Petugas: ${petugasController.text}");
    r.merge(CellIndex.indexByString("E1"), CellIndex.indexByString("H2"),
        customValue: "$namaBandara - $kelasBandara");
    r.merge(CellIndex.indexByString("A4"), CellIndex.indexByString("A5"),
        customValue: "NO");
    r.merge(CellIndex.indexByString("B4"), CellIndex.indexByString("B5"),
        customValue: "Obyek Inspeksi");
    r.merge(CellIndex.indexByString("C4"), CellIndex.indexByString("D4"),
        customValue: "KONDISI");
    r.cell(CellIndex.indexByString("C5")).value = "BAIK";
    r.cell(CellIndex.indexByString("D5")).value = "KURANG";
    r.merge(CellIndex.indexByString("E4"), CellIndex.indexByString("E5"),
        customValue: "Jenis Kerusakan");
    r.merge(CellIndex.indexByString("F4"), CellIndex.indexByString("F5"),
        customValue: "Level Kerusakan");
    r.merge(CellIndex.indexByString("G4"), CellIndex.indexByString("G5"),
        customValue: "Tindak Lanjut");
    r.merge(CellIndex.indexByString("H4"), CellIndex.indexByString("H5"),
        customValue: "Lama Perbaikan");
    r.merge(CellIndex.indexByString("I4"), CellIndex.indexByString("I5"),
        customValue: "Foto");
    int col = 6;
    int no = 1;
    data.forEach((key, value) {
      if (value is Map) {
        r.cell(CellIndex.indexByString("A$col")).value = no++;
        //start
        r.cell(CellIndex.indexByString("B$col")).value = key.toUpperCase();
        col++;
        value.forEach((key2, value2) {
          r.cell(CellIndex.indexByString("B$col")).value = key2;
          if (value2['status'] == 'baik') {
            r.cell(CellIndex.indexByString("C$col")).value = "V";
            r.cell(CellIndex.indexByString("I$col")).value =
                value2['image'] ?? 'Belum diisi';
          } else {
            r.cell(CellIndex.indexByString("D$col")).value = "V";

            r.cell(CellIndex.indexByString("E$col")).value =
                value2['jenisKerusakan'] ?? 'Belum diisi';
            r.cell(CellIndex.indexByString("F$col")).value =
                value2['levelKerusakan'] ?? 'Belum diisi';
            r.cell(CellIndex.indexByString("G$col")).value =
                value2['tindakan'] ?? 'Belum diisi';
            r.cell(CellIndex.indexByString("H$col")).value =
                value2['waktuPerbaikan'] ?? 'Belum diisi';
            r.cell(CellIndex.indexByString("I$col")).value =
                value2['image'] ?? 'Belum diisi';
          }
          col++;
        });
        //end
        col++;
      }
      col++;
    });
    if (Platform.isAndroid) {
      //for phone
      try {
        if (await requestPermission(Permission.storage)) {
          Directory? tempPath = await getExternalStorageDirectory();
          String nwDirectory = "${tempPath!.path.split('Android')[0]}Report";
          directory = Directory(nwDirectory);
        } else {
          Get.snackbar("Oops!", "Izin penyimpanan ditolak");
        }
      } catch (e) {
        Get.snackbar("Oops!", e.toString());
      }
    }
    try {
      if (await requestPermission(Permission.manageExternalStorage)) {
        LoadingDialog.basic();
        var specialName = label.replaceAll('/', '');
        String path = "${directory.path}/Laporan ($specialName).xlsx";
        if (await directory.exists()) {
          File((path))
            ..createSync(recursive: true)
            ..writeAsBytesSync(excel.encode()!);
          Navigator.pop(Get.overlayContext!);
          Get.snackbar("Success", "Berhasil simpan laporan\n$path",
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          await directory.create(recursive: true);
          File((path))
            ..createSync(recursive: true)
            ..writeAsBytesSync(excel.encode()!);
          Get.back();
          Get.snackbar("Oops!", "Berhasil simpan laporan\n$path",
              backgroundColor: Colors.green, colorText: Colors.white);
        }
        final open = await OpenFile.open(path);
        print(open.message);
      } else {
        Get.back();
        Get.snackbar("Oops!", "Izin Penyimpanan ditolak");
      }
    } catch (e) {
      Get.snackbar("Oops!", e.toString());
    }
  }

  @override
  void dispose() {
    petugasController.dispose();
    cuacaController.dispose();
    super.dispose();
  }

  Future<void> accept() async {
    if (formKey.currentState!.validate()) {
      try {
        LoadingDialog.basic();
        data['petugas'] = petugasController.text;
        data['cuaca'] = cuacaController.text;
        data['accept'] = true;
        await LaporanService.accLaporanAll(data);
        await Get.find<AppController>().getData();
        Get.back();
        Get.back();
      } catch (e) {
        Get.back();
        Get.snackbar("Oops!", e.toString());
      }
    }
  }
}
