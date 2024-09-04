import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextForm extends StatelessWidget {
  final String hint;
  final Widget? suffixIcon;
  final bool obscureText;

  const CustomTextForm(
      {super.key,
      required this.hint,
      this.suffixIcon,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp),
      child: TextFormField(
        obscureText: obscureText,
        cursorColor: const Color.fromARGB(179, 147, 147, 147),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding:
              EdgeInsets.only(left: 16.sp, bottom: 14.sp, top: 14.sp),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.sp,
              color: const Color.fromARGB(179, 147, 147, 147),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.amber,
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: "Body",
            // fontWeight: FontWeight.bold,
            color: Color(0xff939393),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(179, 147, 147, 147),
            ),
            borderRadius: BorderRadius.circular(12.sp),
          ),
        ),
      ),
    );
  }
}
