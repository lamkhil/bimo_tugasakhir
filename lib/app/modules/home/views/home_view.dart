import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
              Container(
                margin: const EdgeInsets.fromLTRB(15, 20, 0, 20),
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
              const ListTile(
                dense: true,
                visualDensity: VisualDensity(vertical: -4),
                title: Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(
                  'Pengaturan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                onTap: () {
                  Get.offAllNamed(Routes.LOGIN);
                  sharedPreferences.remove('user');
                },
              ),
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -4),
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text(
                          'Kembali',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Obx(() => Text(controller.title[controller.screenIndex.value])),
      ),
      body: Obx(() {
        return controller.screen[controller.screenIndex.value];
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
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
