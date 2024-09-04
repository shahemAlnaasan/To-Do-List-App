import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/bloc/pop_up_bloc.dart';
import 'package:todo_list_app/view/todo_add_delete_edit/delete_todo.dart';
import 'package:todo_list_app/view/todo_add_delete_edit/edit_todo.dart';
import 'package:todo_list_app/view/widgets/pop_up_date_widget.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(left: 24.sp, right: 24),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 20.sp,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<PopUpBloc>().add(ShowPopupEvent());
                        },
                        child: Image.asset(
                          "icons/clock (3).png",
                          width: 24.sp,
                          height: 24.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 7.sp),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return const EditTodo();
                            },
                          );
                        },
                        child: Image.asset(
                          "icons/edit-2 (1).png",
                          width: 24.sp,
                          height: 24.sp,
                        ),
                      ),
                      SizedBox(width: 7.sp),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: false,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return const DeleteTodo();
                            },
                          );
                        },
                        child: Image.asset(
                          "icons/trash-2 (1).png",
                          width: 24.sp,
                          height: 24.sp,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 24.sp),
              Text(
                "DESIGN LOGO",
                style: TextStyle(
                    fontFamily: "HeadLine",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 24.sp),
              SizedBox(
                width: 327.sp,
                height: 606.sp,
                child: Text(
                  "Make logo for the mini project",
                  style: TextStyle(
                    fontFamily: "Body",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 19.sp),
              SizedBox(
                width: 327.sw,
                child: Text(
                  "Created at Sept 2021",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Body",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
