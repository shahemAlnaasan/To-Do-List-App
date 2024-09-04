import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';

class DeleteTodo extends StatelessWidget {
  const DeleteTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.sp,
      height: 160.sp,
      child: Column(
        children: [
          const CustomButton(
            title: "Delete TODO",
            color: Colors.white,
            textColor: Color(0xffF76C6A),
          ),
          SizedBox(height: 16.sp),
          const CustomButton(
            title: "Cancle",
            color: Colors.white,
            textColor: Colors.green,
          )
        ],
      ),
    );
  }
}
