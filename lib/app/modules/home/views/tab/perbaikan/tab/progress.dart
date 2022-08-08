import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugasakhir/app/modules/home/controllers/tab/perbaikan_controller.dart';

class ProgressTab extends GetView<PerbaikanController> {
  const ProgressTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: controller.inProgress
            .map(
              (element) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          element['title'].toString().toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                        Text(
                          element['data']['title'],
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Row(
                          children: [
                            const Expanded(
                                flex: 1, child: Text("Jenis Kerusakan")),
                            const Text(" : "),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    element['data']['data']['jenisKerusakan']))
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                                flex: 1, child: Text("Level Kerusakan")),
                            const Text(" : "),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    element['data']['data']['levelKerusakan']))
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 1, child: Text("Tindakan")),
                            const Text(" : "),
                            Expanded(
                                flex: 2,
                                child:
                                    Text(element['data']['data']['tindakan']))
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 1, child: Text("Lama Waktu")),
                            const Text(" : "),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    element['data']['data']['waktuPerbaikan']))
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(24.r)),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: element['data']['data']['image'] == null
                                ? const Center(child: Text("Belum Ada Foto"))
                                : Image.network(
                                    element['data']['data']['image'],
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
