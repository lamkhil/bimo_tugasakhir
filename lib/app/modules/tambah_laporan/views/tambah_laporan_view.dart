import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhir/app/data/model/laporan.dart';

import '../controllers/tambah_laporan_controller.dart';

class TambahLaporanView extends GetView<TambahLaporanController> {
  const TambahLaporanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              '${controller.arguments != null ? 'Edit' : 'Tambah'} Laporan'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Container(
              margin: EdgeInsets.all(15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE').format(controller.arguments != null
                        ? DateFormat('dd/MM/yyyy')
                            .parse(controller.data['created_at'])
                        : DateTime.now()),
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('d MMM yyyy').format(controller.arguments != null
                        ? DateFormat('dd/MM/yyyy')
                            .parse(controller.data['created_at'])
                        : DateTime.now()),
                    style: TextStyle(
                      fontSize: 24.sp,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15.r),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Petugas'),
                          TextFormField(
                            controller: controller.petugasController,
                            validator: (val) {
                              if (val?.isEmpty ?? true) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: const Text('Cuaca'),
                          ),
                          TextFormField(
                            controller: controller.cuacaController,
                            validator: (val) {
                              if (val?.isEmpty ?? true) {
                                return 'Required';
                              }
                              return null;
                            },
                          )
                        ]),
                  ),
                  Text(
                    'Runway',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.all(12.r),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: runway
                            .map((e) => Obx(() => controller.data['runway'][e]
                                        ['status'] ==
                                    'rusak'
                                ? rusak(e, 'runway')
                                : baik(e, 'runway')))
                            .toList()),
                  ),
                  Text(
                    'Runway Strip',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.all(12.r),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: runwayStrip
                            .map((e) => Obx(() => controller.data['runwayStrip']
                                        [e]['status'] ==
                                    'rusak'
                                ? rusak(e, 'runwayStrip')
                                : baik(e, 'runwayStrip')))
                            .toList()),
                  ),
                  Text(
                    'Taxiway',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.all(12.r),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: taxiway
                            .map((e) => Obx(() => controller.data['taxiway'][e]
                                        ['status'] ==
                                    'rusak'
                                ? rusak(e, 'taxiway')
                                : baik(e, 'taxiway')))
                            .toList()),
                  ),
                  Text(
                    'Apron',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.all(12.r),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: apron
                            .map((e) => Obx(() =>
                                controller.data['apron'][e]['status'] == 'rusak'
                                    ? rusak(e, 'apron')
                                    : baik(e, 'apron')))
                            .toList()),
                  ),
                  Text(
                    'Drainase',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.all(12.r),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: drainase
                            .map((e) => Obx(() => controller.data['drainase'][e]
                                        ['status'] ==
                                    'rusak'
                                ? rusak(e, 'drainase')
                                : baik(e, 'drainase')))
                            .toList()),
                  ),
                  Text(
                    'Pagar Perimeter',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.all(12.r),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: pagarPerimeter
                            .map((e) => Obx(() => controller
                                        .data['pagarPerimeter'][e]['status'] ==
                                    'rusak'
                                ? rusak(e, 'pagarPerimeter')
                                : baik(e, 'pagarPerimeter')))
                            .toList()),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.amber),
                            onPressed: () {
                              controller.cetak();
                            },
                            child: const Text("Cetak")),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              controller.simpan();
                            },
                            child: const Text("Simpan")),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget baik(e, String cat) {
    return Container(
        // GA RUSAK
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Expanded(child: Text('$e')),
            InkWell(
              onTap: null,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.h),
                height: 30.h,
                width: 50.w,
                color: Colors.yellow,
                alignment: Alignment.center,
                child:
                    const Text('Baik', style: TextStyle(color: Colors.white)),
              ),
            ),
            InkWell(
              onTap: () {
                controller.data[cat][e]['status'] = 'rusak';
                controller.data.refresh();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.h),
                height: 30.h,
                width: 50.w,
                color: Colors.grey,
                alignment: Alignment.center,
                child:
                    const Text('Rusak', style: TextStyle(color: Colors.white)),
              ),
            ),
            InkWell(
              onTap: () {
                controller.pickCameraImage(e, cat);
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.h),
                  height: 30.h,
                  width: 50.w,
                  color: const Color.fromARGB(255, 0, 45, 97),
                  alignment: Alignment.center,
                  child: Obx(
                    () => controller.data[cat][e]['image'] != null
                        ? SizedBox(
                            height: 24.h,
                            width: 42.w,
                            child: Image.network(
                                controller.data[cat][e]['image'],
                                fit: BoxFit.cover),
                          )
                        : const Icon(Icons.add_a_photo_rounded,
                            color: Colors.white),
                  )),
            ),
          ],
        ));
  }

  Widget rusak(e, String cat) {
    return Column(
      children: [
        Container(
            // RUSAK
            margin: EdgeInsets.symmetric(vertical: 5.h),
            child: Row(
              children: [
                Expanded(child: Text('$e')),
                InkWell(
                  onTap: () {
                    controller.data[cat][e]['status'] = 'baik';
                    controller.data.refresh();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.h),
                    height: 30.h,
                    width: 50.w,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('Baik',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                InkWell(
                  onTap: null,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.h),
                    height: 30.h,
                    width: 50.w,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: const Text('Rusak',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.pickCameraImage(e, cat);
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.h),
                      height: 30.h,
                      width: 50.w,
                      color: const Color.fromARGB(255, 0, 45, 97),
                      alignment: Alignment.center,
                      child: Obx(
                        () => controller.data[cat][e]['image'] != null
                            ? SizedBox(
                                height: 24.h,
                                width: 42.w,
                                child: Image.network(
                                  controller.data[cat][e]['image'],
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.add_a_photo_rounded,
                                color: Colors.white),
                      )),
                ),
              ],
            )),
        Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(
                        () => DropdownButton(
                            isExpanded: true,
                            hint: const Text("Jenis Kerusakan"),
                            value: controller.data[cat][e]['jenisKerusakan'],
                            items: controller.jenisKerusakan
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    )))
                                .toList(),
                            onChanged: (val) {
                              controller.data[cat][e]['jenisKerusakan'] = val;
                              controller.data.refresh();
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: Obx(
                        () => DropdownButton(
                            isExpanded: true,
                            hint: const Text("Level Kerusakan"),
                            value: controller.data[cat][e]['levelKerusakan'],
                            items: controller.levelKerusakan
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    )))
                                .toList(),
                            onChanged: (val) {
                              controller.data[cat][e]['levelKerusakan'] = val;
                              controller.data.refresh();
                            }),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(
                        () => DropdownButton(
                            isExpanded: true,
                            hint: const Text("Tindakan"),
                            value: controller.data[cat][e]['tindakan'],
                            items: controller.tindakan
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    )))
                                .toList(),
                            onChanged: (val) {
                              controller.data[cat][e]['tindakan'] = val;
                              controller.data.refresh();
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: Obx(
                        () => DropdownButton(
                            isExpanded: true,
                            hint: const Text("Waktu Perbaikan"),
                            value: controller.data[cat][e]['waktuPerbaikan'],
                            items: controller.waktuPerbaikan
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    )))
                                .toList(),
                            onChanged: (val) {
                              controller.data[cat][e]['waktuPerbaikan'] = val;
                              controller.data.refresh();
                            }),
                      ),
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }
}
