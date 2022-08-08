import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tugasakhir/app/modules/home/controllers/tab/laporan_controller.dart';
import 'package:tugasakhir/app/routes/app_pages.dart';

import '../../../../global/const.dart';

class LaporanTab extends GetView<LaporanController> {
  const LaporanTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () => Get.toNamed(Routes.TAMBAH_LAPORAN,
            arguments: controller.selectedData.value),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Obx(
              () => TableCalendar(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: controller.focusedDay.value,
                selectedDayPredicate: (day) =>
                    isSameDay(controller.selectedDay.value, day),
                rangeStartDay: controller.rangeStart.value,
                rangeEndDay: controller.rangeEnd.value,
                calendarFormat: controller.calendarFormat.value,
                rangeSelectionMode: RangeSelectionMode.disabled,
                eventLoader: null,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                  // Use `CalendarStyle` to customize the UI
                  markerSize: 5,
                  selectedDecoration: BoxDecoration(
                      color: Colors.amber, shape: BoxShape.circle),
                  outsideDaysVisible: false,
                ),
                onDaySelected: controller.onDaySelected,
                onRangeSelected: controller.onRangeSelected,
                onFormatChanged: (format) {
                  if (controller.calendarFormat.value != format) {
                    controller.calendarFormat.value = format;
                  }
                },
                onPageChanged: (focusedDay) {
                  controller.focusedDay.value = focusedDay;
                },
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(child: Obx(() {
            var data = {};
            var dataGlobal = {};
            if (controller.selectedData.value != null) {
              data.addAll(controller.selectedData.value!);
              dataGlobal.addAll(controller.selectedData.value!);
              data.removeWhere((key, value) => value is! Map);
              dataGlobal.removeWhere((key, value) => value is Map);
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              labelData[data.keys.toList()[index]]!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text("Inspeksi Rutin"),
                            Text('Last Update : ${dataGlobal["created_at"]}')
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.TAMBAH_LAPORAN,
                            arguments: controller.selectedData.value);
                      },
                    ));
              },
            );
          })),
        ],
      ),
    );
  }
}
