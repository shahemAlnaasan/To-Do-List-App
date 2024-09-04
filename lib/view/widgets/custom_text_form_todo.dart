import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormTodo extends StatelessWidget {
  final String hint;
  final Widget? suffixIcon;
  final Color? color;
  final TextEditingController? controller;
  final bool? readOnly;
  final void Function()? onTap;

  const CustomTextFormTodo({
    super.key,
    required this.hint,
    this.suffixIcon,
    this.color,
    this.controller,
    this.readOnly,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:
          TextStyle(color: Colors.white, fontFamily: "Body", fontSize: 16.sp),
      onTap: onTap,
      readOnly: readOnly ?? false,
      controller: controller,
      textAlignVertical: TextAlignVertical.top,
      maxLines: null,
      expands: true,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.only(left: 16.sp, bottom: 13.sp, top: 13.sp),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.sp,
            color: color ?? Colors.white,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: "Body",
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.sp,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
    );
  }
}
