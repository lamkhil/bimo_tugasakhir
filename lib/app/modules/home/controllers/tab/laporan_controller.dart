import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tugasakhir/app/global/controllers/app_controller.dart';

class LaporanController extends GetxController {
  Rx<CalendarFormat> calendarFormat = Rx(CalendarFormat.month);
  Rx<RangeSelectionMode> rangeSelectionMode = Rx(RangeSelectionMode
      .toggledOff); // Can be toggled on/off by longpressing a date
  Rx<DateTime> focusedDay = Rx(DateTime.now());
  Rx<DateTime?> selectedDay = Rx(null);
  Rx<DateTime?> rangeStart = Rx(null);
  Rx<DateTime?> rangeEnd = Rx(null);
  Rx<Map<String, dynamic>?> selectedData = Rx(null);

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    rangeStart.value = null; // Important to clean those
    rangeEnd.value = null;
    rangeSelectionMode.value = RangeSelectionMode.toggledOff;
    final result = Get.find<AppController>()
        .data
        .value!
        .docs
        .where((element) =>
            element.id == DateFormat('dd-MM-yyyy').format(selectedDay))
        .toList();
    if (result.isNotEmpty) {
      selectedData.value = result.first.data();
    } else {
      selectedData.value = null;
    }
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    selectedDay.value = null;
    this.focusedDay.value = focusedDay;
    rangeStart.value = start;
    rangeEnd.value = end;
    rangeSelectionMode.value = RangeSelectionMode.toggledOn;

    // `start` or `end` could be null
    // if (start != null && end != null) {
    //   _selectedEvents.value = _getEventsForRange(start, end);
    // } else if (start != null) {
    //   _selectedEvents.value = _getEventsForDay(start);
    // } else if (end != null) {
    //   _selectedEvents.value = _getEventsForDay(end);
    // }
  }

  @override
  void onInit() {
    final result = Get.find<AppController>()
        .data
        .value!
        .docs
        .where((element) =>
            element.id == DateFormat('dd-MM-yyyy').format(DateTime.now()))
        .toList();
    if (result.isNotEmpty) {
      selectedData.value = result.first.data();
    }
    super.onInit();
  }
}

const labelData = {
  'runway': "Run Way",
  'taxiway': "Taxi Way",
  'apron': "Apron",
  'runwayStrip': "Run Way Strip",
  'drainase': "Drainase",
  'pagarPerimeter': "Pagar Perimeter"
};
