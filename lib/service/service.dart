import 'package:intl/intl.dart';

class Services {
  String epochTo12HourTime(int epoch) {
    var date = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    var formatter = DateFormat('h:mm a');
    return formatter.format(date);
  }

  String epochToCustomDateFormat(int epoch) {
    var date = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    var formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }
}
