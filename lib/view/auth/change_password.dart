import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/view/widgets/custom_text_form.dart';
import 'package:todo_list_app/view/widgets/logo.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(height: 180.sp),
              const Center(child: Logo()),
              SizedBox(height: 192.sp),
              CustomTextForm(
                hint: 'Password',
                obscureText: isPassword ? true : false,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(
                      () {
                        isPassword = !isPassword;
                      },
                    );
                  },
                  child: isPassword
                      ? Image.asset(
                          "icons/eye-off.png",
                          color: const Color(0xff939393),
                        )
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          size: 25.sp,
                          color: const Color(0xff939393),
                        ),
                ),
              ),
              SizedBox(height: 16.sp),
              CustomTextForm(
                hint: 'Confirm Password',
                obscureText: isPassword ? true : false,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(
                      () {
                        isPassword = !isPassword;
                      },
                    );
                  },
                  child: isPassword
                      ? Image.asset(
                          "icons/eye-off.png",
                          color: const Color(0xff939393),
                        )
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          size: 25.sp,
                          color: const Color(0xff939393),
                        ),
                ),
              ),
              SizedBox(height: 24.sp),
              Container(
                width: 327.sp,
                height: 48.sp,
                decoration: BoxDecoration(
                  color: const Color(0xffF79E89),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "CHANGE PASSWORD",
                    style: TextStyle(
                      fontFamily: "Body",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
