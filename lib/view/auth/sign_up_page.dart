import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';
import 'package:todo_list_app/view/widgets/custom_text_form.dart';
import 'package:todo_list_app/view/widgets/logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              SizedBox(height: 64.sp),
              const CustomTextForm(
                hint: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 16.sp),
              const CustomTextForm(
                hint: 'Full Name',
                obscureText: false,
              ),
              SizedBox(height: 16.sp),
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
              const CustomButton(title: "SIGN Up"),
              SizedBox(height: 15.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "have an account? ",
                    style: TextStyle(
                      color: const Color(0xff939393),
                      fontFamily: "Body",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    "Log in",
                    style: TextStyle(
                      color: const Color(0xffF79E89),
                      fontFamily: "Body",
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
