import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/bloc/pop_up_bloc.dart';
import 'package:todo_list_app/view/widgets/pop_up_date_widget.dart';

class TodoBox extends StatelessWidget {
  const TodoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 17.sp),
      child: Container(
        width: 327.sp,
        height: 120.sp,
        decoration: BoxDecoration(
          color: const Color(0xffF76C6A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.sp,
          ),
          child: Stack(
            children: [
              BlocBuilder<PopUpBloc, PopupState>(
                builder: (context, state) {
                  if (state.isVisible) {
                    return Positioned(
                      top: 55.sp,
                      right: 12.sp,
                      child: const PopUpDateWidget(),
                    );
                  } else {
                    return const SizedBox
                        .shrink(); // Empty widget when popup is not visible
                  }
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6.sp, bottom: 8, right: 8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Design Logo",
                          style: TextStyle(
                              fontFamily: "Body",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<PopUpBloc>().add(ShowPopupEvent());
                          },
                          child: Image.asset(
                            "icons/clock (3).png",
                            color: Colors.white,
                            width: 16.sp,
                            height: 16.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 270.sp,
                    height: 45.sp,
                    child: Text(
                      "Make Ui design for the mini project post figma link to the trello using",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Body",
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  Text(
                    "Created at 1 Sept 2021",
                    style: TextStyle(
                        fontFamily: "Body",
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
