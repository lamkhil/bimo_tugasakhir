import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';
import 'package:tugasakhir/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalisaView extends GetView<HomeController> {
  const AnalisaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getData();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            "Analisa Grafik Kerusakan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(
            height: 24.h,
          ),
          const Text("Taxiway"),
          chartView(controller.data1),
          const Text("Drainase"),
          chartView(controller.data2),
          const Text("Pagar Perimeter"),
          chartView(controller.data3),
          const Text("Runway"),
          chartView(controller.data4),
          const Text("Apron"),
          chartView(controller.data5),
          const Text("Runway Strip"),
          chartView(controller.data6),
        ]),
      ),
    );
  }

  AspectRatio chartView(data) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: LineChart(
          LineChartData(
            maxX: 11,
            minX: 0,
            maxY: 4,
            lineTouchData: LineTouchData(
              enabled: true,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: data,
                isCurved: false,
                barWidth: 2,
                color: Colors.amber,
                dotData: FlDotData(
                  show: true,
                ),
              ),
            ],
            minY: 0,
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 18,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                axisNameSize: 20,
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 48.w,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var lastData = Get.find<AppController>().data.value!.docs.last;
    final date = [
      "JAN",
      "FEB",
      'MAR',
      'APR',
      'MEI',
      'JUN',
      'JUL',
      'AGU',
      'SEP',
      'OKT',
      'NOV',
      'DES',
      "JAN",
      "FEB",
      'MAR',
      'APR',
      'MEI',
      'JUN',
      'JUL',
      'AGU',
      'SEP',
      'OKT',
      'NOV',
      'DES',
      "JAN",
      "FEB",
      'MAR',
      'APR',
      'MEI',
      'JUN',
      'JUL',
      'AGU',
      'SEP',
      'OKT',
      'NOV',
      'DES',
    ];
    DateTime lastDate =
        DateFormat('dd/MM/yyyy').parse(lastData.data()['created_at']);
    int month = lastDate.month;
    String text = "";
    for (var i = 0; i < 12; i++) {
      var index = month + i;

      if (value.toInt() == i) {
        text = date[index];
      }
    }
    if (text.isEmpty) {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: _dateTextStyle),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 12.0);
    String text = "";
    final level = ['Ringan', 'Sedang', 'Berat'];
    for (var i = 1; i < 5; i++) {
      if (value.toInt() == i) {
        if (i < 4) {
          text = level[i - 1];
        }
      }
    }
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  static const _dateTextStyle = TextStyle(
    fontSize: 10,
    color: Colors.amber,
    fontWeight: FontWeight.bold,
  );
}
