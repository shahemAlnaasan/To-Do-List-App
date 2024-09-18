import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/model/user_data/user_data.dart';
import 'package:todo_list_app/view/widgets/overLay_deadLine.dart';

class TodoBox extends StatefulWidget {
  final UserData userData;
  final String formatedDate;
  final String formatedDeadLine;

  const TodoBox({
    super.key,
    required this.userData,
    required this.formatedDate,
    required this.formatedDeadLine,
  });

  @override
  State<TodoBox> createState() => _TodoBoxState();
}

class _TodoBoxState extends State<TodoBox> {
  bool isVisible = false;
  bool isDeadLinePassedVisible = true;

  @override
  void initState() {
    isDeadLinePassedVisible = true;
    super.initState();
  }

  void togglePopup() {
    setState(() {
      isVisible = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isVisible = false;
      });
    });
  }

  bool isDeadlineToday(DateTime? deadline) {
    final today = DateTime.now();
    return deadline?.year == today.year &&
        deadline?.month == today.month &&
        deadline?.day == today.day;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: isVisible
                ? ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  )
                : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Container(
              width: 327.sp,
              height: 120.sp,
              decoration: BoxDecoration(
                color: widget.userData.deadline != null
                    ? const Color(0xffF76C6A)
                    : const Color(0xffF79E89).withOpacity(isVisible ? 0.8 : 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 6.sp, bottom: 8, right: 8.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.userData.title,
                            style: TextStyle(
                              fontFamily: "Body",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                          widget.userData.deadline != null
                              ? InkWell(
                                  onTap: togglePopup,
                                  child: Image.asset(
                                    "icons/clock.png",
                                    color: Colors.white,
                                    width: 18,
                                    height: 18,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 270.sp,
                      height: 40.sp,
                      child: Text(
                        widget.userData.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: "Body",
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    Text(
                      widget.formatedDate,
                      style: TextStyle(
                        fontFamily: "Body",
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isVisible)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = false;
                });
              },
              child: DeadLineOverLay(
                userData: widget.userData,
                title: widget.formatedDeadLine,
              ),
            ),
          ),
        if (widget.userData.deadline != null &&
            isDeadlineToday(widget.userData.deadline) &&
            isDeadLinePassedVisible)
          Positioned.fill(
            child: InkWell(
              onTap: () {
                setState(() {
                  isDeadLinePassedVisible = false;
                });
              },
              child: DeadLineOverLay(
                userData: widget.userData,
                title: "DeadLine Passed",
              ),
            ),
          ),
      ],
    );
  }
}
