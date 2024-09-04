import 'package:intl/intl.dart';

class DateModel {
  DateTime? selectedDate;

  DateModel({this.selectedDate});

  String formateDate() {
    if (selectedDate != null) {
      String dateFormate = DateFormat('dd MMMM yyyy').format(selectedDate!);
      return dateFormate;
    }
    return "";
  }
}
