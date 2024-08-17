import 'package:intl/intl.dart';

DateTime toDate({required String dateTime}) {
  final utcDateTime = DateTime.parse(dateTime);
  return utcDateTime.toLocal();
}

String formatDate({
  required String dateTime,
  format = "dd MMM, yyyy"
}) {
  final localDateTime = toDate(dateTime: dateTime);
  return DateFormat(format).format(localDateTime);
}
