import "package:intl/intl.dart";

extension DateTimeExtension on DateTime {
  String toFormattedString(String format) {
    var formatter = DateFormat(format);
    return formatter.format(this);
  }
}
