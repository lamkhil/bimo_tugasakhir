import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/modules/home/views/analisa_view.dart';
import 'package:tugasakhir/app/routes/app_pages.dart';
import 'package:tugasakhir/main.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 20, 0, 20),
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(
                          Get.find<AppController>().user.value!.nama,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(Get.find<AppController>().user.value!.username),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text(
                  'Home',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                onTap: () {
                  controller.screenDrawer.value = null;
                  Get.back();
                },
              ),
              const Divider(),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text(
                  'Analisa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                onTap: () {
                  controller.drawerTitle.value = "Analisa";
                  controller.screenDrawer.value = const AnalisaView();
                  Get.back();
                },
              ),
              const Divider(),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      )),
                      child: ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -4),
                        title: const Text(
                          'Sign Out',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        onTap: () {
                          Get.offAllNamed(Routes.LOGIN);
                          sharedPreferences.remove('user');
                        },
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Obx(() => controller.screenDrawer.value != null
            ? Text(controller.drawerTitle.value)
            : Text(controller.title[controller.screenIndex.value])),
      ),
      body: Obx(() {
        return controller.screenDrawer.value == null
            ? controller.screen[controller.screenIndex.value]
            : controller.screenDrawer.value!;
      }),
      bottomNavigationBar: Obx(
        () => controller.screenDrawer.value != null
            ? const SizedBox.shrink()
            : BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Perbaikan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.task),
                    label: 'Laporan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'Notifikasi',
                  ),
                ],
                selectedItemColor: const Color.fromRGBO(15, 42, 86, 1),
                currentIndex: controller.screenIndex.value,
                onTap: (val) {
                  controller.screenIndex.value = val;
                },
              ),
      ),
    );
  }
}
