import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/view/filter/filter_todo.dart';
import 'package:todo_list_app/view/todo_add_delete_edit/add_todo.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';
import 'package:todo_list_app/view/widgets/custom_icon_size.dart';
import 'package:todo_list_app/view/widgets/todo_box.dart';

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
          // mainAxisAlignment: MainAxisAlignment.center,
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
                  "Devin L. Waller",
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
                  "DevinWaller17@gmail.com",
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
                Text(
                  "Change Password",
                  style: TextStyle(
                    fontFamily: "Body",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffF76C6A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.sp),
            const CustomButton(title: "LOG OUT"),
          ],
        ),
      ),
    );
  }
}
