import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir/app/global/bindings/app_binding.dart';
import 'package:tugasakhir/firebase_options.dart';

import 'app/data/model/user.dart';
import 'app/global/controllers/app_controller.dart';
import 'app/routes/app_pages.dart';

const Map<int, Color> colorCodes = {
  50: Color.fromRGBO(15, 42, 86, .1),
  100: Color.fromRGBO(15, 42, 86, .2),
  200: Color.fromRGBO(15, 42, 86, .3),
  300: Color.fromRGBO(15, 42, 86, .4),
  400: Color.fromRGBO(15, 42, 86, .5),
  500: Color.fromRGBO(15, 42, 86, .6),
  600: Color.fromRGBO(15, 42, 86, .7),
  700: Color.fromRGBO(15, 42, 86, .8),
  800: Color.fromRGBO(15, 42, 86, .9),
  900: Color.fromRGBO(15, 42, 86, 1),
};
late final SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return GetMaterialApp(
            title: "Application",
            theme: ThemeData(
              primarySwatch: const MaterialColor(0xFF0F2A56, colorCodes),
            ),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            initialBinding: AppBinding(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
