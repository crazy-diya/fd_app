
import 'package:intl/intl.dart';

extension ConvertToDate on int {
  String convertTimestampToData() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);

    print(formattedDate);
    return formattedDate;
  }
}
