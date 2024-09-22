import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/auth_bloc/auth_bloc.dart';
import '../../widgets/custom_progress_indecator.dart';
import '../../widgets/custom_text_form.dart';
import '../../widgets/logo.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String? boxName;
  const ChangePasswordScreen({super.key, required this.boxName});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode oldPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  bool isPasswordVisivle = true;
  bool isNewPassword = true;
  bool isConfirmPassword = true;

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
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.sp),
              child: Column(
                children: [
                  SizedBox(height: 60.sp),
                  Container(
                      alignment: const Alignment(-0.9, 0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios))),
                  Column(
                    children: [
                      SizedBox(height: 70.sp),
                      const Center(child: Logo()),
                      SizedBox(height: 80.sp),
                      CustomTextForm(
                        focusNode: emailFocusNode,
                        onFieldSubmittedl: (_) {
                          FocusScope.of(context)
                              .requestFocus(oldPasswordFocusNode);
                        },
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
                        focusNode: oldPasswordFocusNode,
                        onFieldSubmittedl: (_) {
                          FocusScope.of(context)
                              .requestFocus(newPasswordFocusNode);
                        },
                        controller: oldPasswordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return 'Please enter a password with at least 8 letters';
                          }
                          return null;
                        },
                        hint: 'Old Password',
                        obscureText: isPasswordVisivle ? true : false,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(
                              () {
                                isPasswordVisivle = !isPasswordVisivle;
                              },
                            );
                          },
                          child: isPasswordVisivle
                              ? Image.asset(
                                  "icons/eye-off.png",
                                  color: const Color(0xff939393),
                                )
                              : const Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 25,
                                  color: Color(0xff939393),
                                ),
                        ),
                      ),
                      SizedBox(height: 16.sp),
                      CustomTextForm(
                        focusNode: newPasswordFocusNode,
                        onFieldSubmittedl: (_) {
                          FocusScope.of(context)
                              .requestFocus(confirmPasswordFocusNode);
                        },
                        controller: newPasswordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return 'Please enter a password with at least 8 letters';
                          }
                          return null;
                        },
                        hint: 'New Password',
                        obscureText: isNewPassword ? true : false,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(
                              () {
                                isNewPassword = !isNewPassword;
                              },
                            );
                          },
                          child: isNewPassword
                              ? Image.asset(
                                  "icons/eye-off.png",
                                  color: const Color(0xff939393),
                                )
                              : const Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 25,
                                  color: Color(0xff939393),
                                ),
                        ),
                      ),
                      SizedBox(height: 16.sp),
                      CustomTextForm(
                        focusNode: confirmPasswordFocusNode,
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return 'Please enter a password with at least 8 letters';
                          }
                          return null;
                        },
                        hint: 'Confirm Password',
                        obscureText: isConfirmPassword ? true : false,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(
                              () {
                                isConfirmPassword = !isConfirmPassword;
                              },
                            );
                          },
                          child: isConfirmPassword
                              ? Image.asset(
                                  "icons/eye-off.png",
                                  color: const Color(0xff939393),
                                )
                              : const Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 25,
                                  color: Color(0xff939393),
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
                          } else if (state.status ==
                              AuthStatus.passwordChanged) {
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
                                              confirmPasswordController.text
                                                  .trim(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
