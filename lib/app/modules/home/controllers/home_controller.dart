import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/modules/home/views/tab/laporan.dart';
import 'package:tugasakhir/app/modules/home/views/tab/notifikasi.dart';
import 'package:tugasakhir/app/modules/home/views/tab/perbaikan/perbaikan.dart';

class HomeController extends GetxController {
  final screenIndex = 1.obs;
  final title = [
    'Perbaikan',
    'Laporan',
    'Notifikasi',
  ];
  final screen = [const PerbaikanTab(), const LaporanTab(), const Notif()];
}
