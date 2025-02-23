import 'package:intl/intl.dart';

String dateFormat(DateTime date) {
  return DateFormat('MMM dd, yyyy').format(date);
}

String dateTimeFormat(DateTime date) {
  return DateFormat('MMM dd, yyyy hh:mm a').format(date);
}
