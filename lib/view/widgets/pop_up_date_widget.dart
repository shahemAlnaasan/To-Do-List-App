import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpDateWidget extends StatelessWidget {
  final String formatedDeadLine;
  const PopUpDateWidget({super.key, required this.formatedDeadLine});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, 0.3),
      children: [
        Image.asset(
          "icons/DEADLINE.png",
          color: const Color(0xffF76C6A),
          width: 126.sp,
          height: 55.sp,
        ),
        Text(
          formatedDeadLine,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Body",
              fontSize: 11.sp,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
