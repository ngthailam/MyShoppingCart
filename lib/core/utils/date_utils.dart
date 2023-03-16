import 'package:intl/intl.dart';

extension MillisExt on int {
  String formatHomeCartTime() {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    return DateFormat('MMM dd, hh:mm', 'en').format(dateTime);
  }
}
