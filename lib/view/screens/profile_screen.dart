import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/auth_bloc/auth_bloc.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';
import 'package:todo_list_app/view/widgets/custom_icon_size.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Padding(
          padding: EdgeInsets.all(9.0.sp),
          child: Text(
            "TO DO LIST",
            style: TextStyle(
                fontFamily: "HeadLine",
                color: const Color(0xffF79E89),
                fontSize: 25.sp),
          ),
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.only(right: 26),
              child: SizedIcon(
                name: "icons/settings.png",
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 114.sp),
            Center(
              child: Image.asset(
                "icons/rafiki.png",
                width: 344,
                height: 252,
              ),
            ),
            SizedBox(height: 109.sp),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Full Name",
                          style: TextStyle(
                              fontFamily: "Body",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          state.userInfo!.fullName,
                          style: TextStyle(
                            fontFamily: "Body",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffF76C6A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                              fontFamily: "Body",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          state.userInfo!.email,
                          style: TextStyle(
                            fontFamily: "Body",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffF76C6A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Password",
                          style: TextStyle(
                              fontFamily: "Body",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("ChangePassword",
                                arguments: {"boxName": state.userInfo!.email});
                          },
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                              fontFamily: "Body",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffF76C6A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.sp),
                    CustomButton(
                      title: "LOG OUT",
                      onTap: () {
                        context.read<AuthBloc>().add(
                              LogoutEvent(
                                email: state.userInfo!.email,
                              ),
                            );
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "Signin", (context) => false);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
