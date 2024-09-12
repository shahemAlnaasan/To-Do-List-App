import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/auth_bloc/auth_bloc.dart';
import 'package:todo_list_app/view/widgets/custom_progress_indecator.dart';
import 'package:todo_list_app/view/widgets/custom_text_form.dart';
import 'package:todo_list_app/view/widgets/logo.dart';

class ChangePassword extends StatefulWidget {
  final String? boxName;
  const ChangePassword({super.key, required this.boxName});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPassword = true;

  @override
  void initState() {
    if (widget.boxName != null) {
      emailController.text = widget.boxName!;
    }
    super.initState();
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
                SizedBox(height: 90.sp),
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
                  controller: oldPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Please enter a password with at least 8 letters';
                    }
                    return null;
                  },
                  hint: 'Old Password',
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
                  controller: newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Please enter a password with at least 8 letters';
                    }
                    return null;
                  },
                  hint: 'New Password',
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
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Please enter a password with at least 8 letters';
                    }
                    return null;
                  },
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
                    if (state.status == AuthStatus.authError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    } else if (state.status == AuthStatus.passwordChanged) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.status == AuthStatus.authLoading) {
                      return const CustomProgressIndecator();
                    } else {
                      return InkWell(
                        child: Container(
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
                        onTap: () {
                          if (formKey.currentState!.validate() == true) {
                            context.read<AuthBloc>().add(
                                  ChangePasswordEvent(
                                    email: emailController.text.trim(),
                                    oldPassword:
                                        oldPasswordController.text.trim(),
                                    newPassword:
                                        newPasswordController.text.trim(),
                                    confirmPassword:
                                        confirmPasswordController.text.trim(),
                                  ),
                                );
                          }
                        },
                      );
                    }
                  },
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
