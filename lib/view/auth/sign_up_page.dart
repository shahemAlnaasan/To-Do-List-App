import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/auth_bloc/auth_bloc.dart';
import 'package:todo_list_app/model/user_info/user_info.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';
import 'package:todo_list_app/view/widgets/custom_progress_indecator.dart';
import 'package:todo_list_app/view/widgets/custom_text_form.dart';
import 'package:todo_list_app/view/widgets/logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                SizedBox(height: 180.sp),
                const Center(child: Logo()),
                SizedBox(height: 64.sp),
                CustomTextForm(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    String pattern = r'^[^@]+@[^@]+\.[^@]+$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  hint: 'Email',
                  obscureText: false,
                ),
                SizedBox(height: 16.sp),
                CustomTextForm(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return 'Please enter a vaild name';
                    }
                    return null;
                  },
                  controller: fullNameController,
                  hint: 'Full Name',
                  obscureText: false,
                ),
                SizedBox(height: 16.sp),
                CustomTextForm(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Please enter a password with at least 8 letters';
                    }
                    return null;
                  },
                  controller: passwordController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Please enter a password with at least 8 letters';
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
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
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status == AuthStatus.authenticated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sign up successful!'),
                        ),
                      );
                      Navigator.pop(context);
                    } else if (state.status == AuthStatus.authError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.status == AuthStatus.authLoading) {
                      return const CustomProgressIndecator();
                    } else {
                      return CustomButton(
                        title: "SIGN UP",
                        onTap: () {
                          final String email = emailController.text;
                          final String fullName = fullNameController.text;
                          final String password = passwordController.text;
                          final String confirmPassword =
                              confirmPasswordController.text;
                          final UserInfo userInfo = UserInfo(
                            fullName: fullName,
                            email: email,
                            password: password,
                            confirmPassword: confirmPassword,
                            accessToken: "",
                          );
                          if (formKey.currentState?.validate() == true) {
                            context.read<AuthBloc>().add(
                                  SignupEvent(
                                    userInfo: userInfo,
                                  ),
                                );
                          }
                        },
                      );
                    }
                  },
                ),
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
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: const Color(0xffF79E89),
                          fontFamily: "Body",
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 46.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
