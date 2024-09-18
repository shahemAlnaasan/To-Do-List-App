import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormTodo extends StatelessWidget {
  final String hint;
  final Widget? suffixIcon;
  final Color? color;
  final TextEditingController? controller;
  final bool? readOnly;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final Color? hintColor;
  final Color? suffixIconColor;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const CustomTextFormTodo({
    super.key,
    required this.hint,
    this.suffixIcon,
    this.color,
    this.controller,
    this.readOnly,
    this.onTap,
    this.keyboardType,
    this.hintColor,
    this.suffixIconColor,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
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
        suffixIconColor: suffixIconColor,
        contentPadding: EdgeInsets.only(left: 16.sp, bottom: 13.sp, top: 13.sp),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2.sp,
              color: color ?? const Color.fromARGB(112, 255, 255, 255)),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: "Body",
          color: hintColor ?? Colors.white,
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


// Color(0xffF0F0F0)

// Color.fromARGB(112, 255, 255, 255)