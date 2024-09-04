import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';
import 'package:todo_list_app/view/widgets/custom_text_form.dart';
import 'package:todo_list_app/view/widgets/logo.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              SizedBox(height: 170.sp),
              const CustomTextForm(
                hint: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 16.sp),
              CustomTextForm(
                hint: 'Password',
                obscureText: isPassword ? true : false,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
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
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.only(left: 243.sp, top: 15.sp),
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                      fontFamily: "Body",
                      color: const Color(0xff939393),
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp),
                ),
              ),
              SizedBox(height: 16.sp),
              const CustomButton(title: "SIGN IN"),
              SizedBox(height: 15.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: const Color(0xff939393),
                      fontFamily: "Body",
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    "Sign up",
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
