import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  const CustomButton(
      {super.key, required this.title, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.sp,
      height: 48.sp,
      decoration: BoxDecoration(
        color: color ?? const Color(0xffF79E89),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: "Body",
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
