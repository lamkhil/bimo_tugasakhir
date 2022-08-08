import 'dart:convert';

import 'package:get/get.dart';

import '../../main.dart';
import '../data/model/user.dart';
import '../global/controllers/app_controller.dart';
import '../modules/bandara_form/bindings/bandara_form_binding.dart';
import '../modules/bandara_form/views/bandara_form_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/tambah_laporan/bindings/tambah_laporan_binding.dart';
import '../modules/tambah_laporan/views/tambah_laporan_view.dart';

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String get INITIAL {
    if (sharedPreferences.getString('user') != null) {
      Future.delayed(Duration.zero).then((value) {
        if (Get.find<AppController>().user.value == null) {
          Get.find<AppController>().user.value =
              User.fromMap(json.decode(sharedPreferences.getString('user')!));
        }
      });
      return Routes.BANDARA_FORM;
    }
    return Routes.LOGIN;
  }

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_LAPORAN,
      page: () => const TambahLaporanView(),
      binding: TambahLaporanBinding(),
    ),
    GetPage(
      name: _Paths.BANDARA_FORM,
      page: () => const BandaraFormView(),
      binding: BandaraFormBinding(),
    ),
  ];
}
