import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/auth_bloc/auth_bloc.dart';
import 'package:todo_list_app/view/screens/home_screen.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';
import 'package:todo_list_app/view/widgets/custom_progress_indecator.dart';
import 'package:todo_list_app/view/widgets/custom_text_form.dart';
import 'package:todo_list_app/view/widgets/logo.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool isPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                SizedBox(height: 140.sp),
                const Center(child: Logo()),
                SizedBox(height: 170.sp),
                CustomTextForm(
                  focusNode: emailFocusNode,
                  onFieldSubmittedl: (_) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
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
                  focusNode: passwordFocusNode,
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
                  child: InkWell(
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          fontFamily: "Body",
                          color: const Color(0xff939393),
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("ChangePassword",
                          arguments: {"boxName": emailController.text});
                    },
                  ),
                ),
                SizedBox(height: 16.sp),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status == AuthStatus.authError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    } else if (state.status == AuthStatus.authenticated) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    }
                  },
                  builder: (context, state) {
                    if (state.status == AuthStatus.authLoading) {
                      return const CustomProgressIndecator();
                    } else {
                      return CustomButton(
                        title: "SIGN IN",
                        onTap: () {
                          if (formKey.currentState?.validate() == true) {
                            context.read<AuthBloc>().add(
                                  LoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
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
                      "Don't have an account? ",
                      style: TextStyle(
                        color: const Color(0xff939393),
                        fontFamily: "Body",
                        fontSize: 12.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("Signup");
                      },
                      child: Text(
                        "Sign up",
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
