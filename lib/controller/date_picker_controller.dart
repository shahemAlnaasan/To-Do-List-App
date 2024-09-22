import 'package:flutter/material.dart';
import '../model/date_model.dart';

class DatePickerController {
  final DateModel dateModel = DateModel();
  final TextEditingController dateController = TextEditingController();

  Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picker != null) {
      dateModel.selectedDate = picker;
      dateController.text = dateModel.formateDate(picker);
    }
    return dateModel.selectedDate;
  }
}
