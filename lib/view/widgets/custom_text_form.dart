import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextForm extends StatelessWidget {
  final String hint;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmittedl;

  const CustomTextForm(
      {super.key,
      required this.hint,
      this.suffixIcon,
      required this.obscureText,
      this.controller,
      this.validator,
      this.focusNode,
      this.onFieldSubmittedl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmittedl,
        textInputAction: TextInputAction.next,
        focusNode: focusNode,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: obscureText,
        cursorColor: const Color.fromARGB(179, 147, 147, 147),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.sp,
              color: const Color.fromARGB(179, 147, 147, 147),
            ),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          suffixIcon: suffixIcon,
          contentPadding:
              EdgeInsets.only(left: 16.sp, bottom: 14.sp, top: 14.sp),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.sp,
              color: const Color.fromARGB(179, 147, 147, 147),
            ),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          fillColor: Colors.amber,
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: "Body",
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
