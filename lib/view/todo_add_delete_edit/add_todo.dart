import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/date_picker_controller.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';
import 'package:todo_list_app/view/widgets/custom_text_form_todo.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    DatePickerController datePickerController = DatePickerController();
    return Container(
        width: 375.sp,
        height: 722.sp,
        decoration: const BoxDecoration(
            color: Color(0xffF79E89),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.only(top: 16.sp, left: 24.sp, right: 24.sp),
          child: Column(
            children: [
              Image.asset("icons/Rectangle 18.png"),
              SizedBox(height: 20.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 327.sp,
                    height: 48.sp,
                    child: const CustomTextFormTodo(
                      hint: 'Title',
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  SizedBox(
                    width: 327.sp,
                    height: 400.sp,
                    child: const CustomTextFormTodo(
                      hint: 'Description',
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  SizedBox(
                    width: 327.sp,
                    height: 48.sp,
                    child: CustomTextFormTodo(
                      readOnly: true,
                      controller: datePickerController.dateController,
                      hint: 'Deadline (Optional)',
                      suffixIcon: Image.asset("icons/calendar.png"),
                      onTap: () {
                        datePickerController.selectDate(context);
                      },
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  SizedBox(
                    width: 327.sp,
                    height: 48.sp,
                    child: CustomTextFormTodo(
                      hint: 'Add Image (Optional)',
                      suffixIcon: Image.asset("icons/image.png"),
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  const CustomButton(
                    title: "ADD TODO",
                    color: Colors.white,
                    textColor: Color(0xffF79E89),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
