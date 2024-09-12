import 'package:intl/intl.dart';

class DateModel {
  DateTime? selectedDate;
  DateTime get nowDate => DateTime.now();

  DateModel({this.selectedDate});

  String formateDate(DateTime? date) {
    if (date != null) {
      String dateFormate = DateFormat('dd MMMM yyyy').format(date);
      return dateFormate;
    }
    return "";
  }
}
