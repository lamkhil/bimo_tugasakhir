import 'dart:io';

import 'package:better_open_file/better_open_file.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugasakhir/app/modules/tambah_laporan/controllers/tambah_laporan_controller.dart';

import '../../../global/const.dart';
import '../../../global/widgets/loading.dart';
import '../../bandara_form/controllers/bandara_form_controller.dart';

TableRow getTitle(int no, String title) {
  return TableRow(children: [
    Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text("$no",
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 10))),
    Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
  ]);
}

TableRow getBody(key, value) {
  if (value['status'] == 'baik') {
    return TableRow(children: [
      SizedBox(height: 12),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text("$key",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10))),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text("V",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10))),
      SizedBox(height: 12),
      SizedBox(height: 12),
      SizedBox(height: 12),
      SizedBox(height: 12),
      SizedBox(height: 12),
    ]);
  } else {
    return TableRow(children: [
      SizedBox(height: 12),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text("$key",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10))),
      SizedBox(height: 12),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text("V",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10))),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value['jenisKerusakan'] ?? "Belum diisi",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10))),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value['levelKerusakan'] ?? "Belum diisi",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10))),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value['tindakan'] ?? "Belum diisi",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10))),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value['waktuPerbaikan'] ?? "Belum diisi",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10))),
    ]);
  }
}

Future<void> pdf() async {
  final controller = Get.find<TambahLaporanController>();
  final pdf = Document();

  final space = TableRow(children: [
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
    SizedBox(height: 12),
  ]);

  int no = 1;
  List<TableRow> valueShow = [];
  controller.data.forEach((key, value) {
    if (value is Map) {
      valueShow.add(getTitle(no++, key.toUpperCase()));
      value.forEach((key2, value2) {
        valueShow.add(getBody(key2, value2));
      });
      valueShow.add(space);
    }
  });

  var directory = Directory('');
  final date = DateFormat('dd/MM/yyyy').parse(controller.data['created_at']);
  String label = "$kelasBandara-$namaBandara ${controller.data['created_at']}";
  try {
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a3,
        build: (Context context) {
          return Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                    "Hari/Tanggal:${DateFormat('EEE/dd-MM-yyyy').format(date)}"),
                Text("Jam:${DateFormat('hh:mm:ss').format(date)}"),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Cuaca: ${controller.cuacaController.text}"),
                Text("Petugas: ${controller.petugasController.text}"),
              ]),
              Center(child: Text("$namaBandara - $kelasBandara"))
            ]),
            SizedBox(height: 24),
            Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(12),
                  1: FixedColumnWidth(24),
                  2: FixedColumnWidth(18),
                  3: FixedColumnWidth(18),
                  4: FixedColumnWidth(18),
                  5: FixedColumnWidth(18),
                  6: FixedColumnWidth(18),
                  7: FixedColumnWidth(18),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: <Widget>[
                      Center(
                          child: Text("\n\nNO\n\n\n",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Center(
                          child: Text("Obyek Inspeksi",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Center(
                          child: Text("Kondisi Baik",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Center(
                          child: Text("Kondisi Kurang",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Center(
                          child: Text("Jenis\nKerusakan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Center(
                          child: Text("Level\nKerusakan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Center(
                          child: Text("Tindak\nLanjut",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Center(
                          child: Text("Waktu\nPerbaikan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  space,
                  ...valueShow
                ])
          ]); // Center
        }));
  } catch (e) {
    Get.back();
    print(e);
  }

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
      String path = "${directory.path}/Laporan ($specialName).pdf";
      if (await directory.exists()) {
        File((path))
          ..createSync(recursive: true)
          ..writeAsBytes(await pdf.save());
        Get.back();
        Get.snackbar("Success", "Berhasil simpan laporan\n$path",
            backgroundColor: material.Colors.green,
            colorText: material.Colors.white);
      } else {
        await directory.create(recursive: true);
        File((path))
          ..createSync(recursive: true)
          ..writeAsBytes(await pdf.save());
        Get.back();
        Get.snackbar("Oops!", "Berhasil simpan laporan\n$path",
            backgroundColor: material.Colors.green,
            colorText: material.Colors.white);
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
