import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/auth_bloc/auth_bloc.dart';
import 'package:todo_list_app/view/auth/change_password.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';
import 'package:todo_list_app/view/widgets/custom_icon_size.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 24.sp),
              child: const SizedIcon(
                name: "icons/settings (1).png",
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
                width: 326.12.sp,
                height: 243.sp,
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChangePassword(
                                  boxName: state.userInfo!.email,
                                ),
                              ),
                            );
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
