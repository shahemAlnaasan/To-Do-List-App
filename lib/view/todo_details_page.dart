import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/todo_bloc/todo_bloc.dart';
import 'package:todo_list_app/model/user_data/user_data.dart';
import 'package:todo_list_app/view/todo_add_delete_edit/delete_todo.dart';
import 'package:todo_list_app/view/todo_add_delete_edit/edit_todo.dart';
import 'package:todo_list_app/view/widgets/pop_up_date_widget.dart';

class TodoDetail extends StatefulWidget {
  final UserData userData;
  final String formatedDate;
  final int index;
  final String formatedDeadLine;

  const TodoDetail({
    super.key,
    required this.userData,
    required this.formatedDate,
    required this.index,
    required this.formatedDeadLine,
  });

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  final ScrollController scrollController = ScrollController();
  bool _showFab = true;
  bool isVisible = false;
  Future? popupTimer;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_toggleFabVisibility);
  }

  @override
  void dispose() {
    scrollController.removeListener(_toggleFabVisibility);
    scrollController.dispose();

    if (popupTimer != null) {
      popupTimer = null;
    }

    super.dispose();
  }

  void togglePopup() {
    if (!mounted) return;
    setState(() {
      isVisible = true;
    });

    popupTimer = Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        isVisible = false;
      });
    });
  }

  void _toggleFabVisibility() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_showFab) setState(() => _showFab = false);
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_showFab) setState(() => _showFab = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    File? image;
    if (widget.userData.image != null) {
      image = File(widget.userData.image!);
    }

    return Scaffold(
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.status == TodoStatus.success) {
            // if (widget.index >= 0 && widget.index < state.userData!.length) {
            //   // Safe to update userData only if the index is valid
            //   final updatedUserData = state.userData![widget.index];
            //   setState(() {
            //     widget.userData.title = updatedUserData.title;
            //     widget.userData.description = updatedUserData.description;
            //     widget.userData.image = updatedUserData.image;
            //     widget.userData.deadline =
            //         updatedUserData.deadline ?? widget.userData.deadline;
            //   });
            // }
          }
        },
        child: Stack(
          children: [
            if (isVisible)
              Positioned(
                top: 64.sp,
                right: 35.sp,
                child: PopUpDateWidget(
                  formatedDeadLine: widget.formatedDeadLine,
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 24.sp, right: 24.sp, top: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 20.sp,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              togglePopup();
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
                                  return EditTodo(
                                    userData: widget.userData,
                                    index: widget.index,
                                  );
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
                                  return DeleteTodo(
                                    index: widget.index,
                                  );
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
                      ),
                    ],
                  ),
                  SizedBox(height: 24.sp),
                  Text(
                    widget.userData.title.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "HeadLine",
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Text(
                          widget.userData.description,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "Body",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        widget.userData.image != null
                            ? Container(
                                alignment: Alignment.center,
                                height: 350.sp,
                                child: Image.file(image!),
                              )
                            : const SizedBox(),
                        SizedBox(height: 20.sp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedSlide(
        duration: duration,
        offset: _showFab ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: duration,
          opacity: _showFab ? 1 : 0,
          child: Container(
            color: Colors.white,
            width: MediaQuery.sizeOf(context).width,
            height: 30,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.transparent,
              elevation: 1000,
              child: Text(
                "Created at ${widget.formatedDate}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Body",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
