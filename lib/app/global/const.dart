import 'package:permission_handler/permission_handler.dart';

final kToday = DateTime.now();
// final Arr = [kToday, kTomorrow];
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

Future<bool> requestPermission(Permission p) async {
  if (await p.isGranted) {
    return true;
  } else {
    var result = await p.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
