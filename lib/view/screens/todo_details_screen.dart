import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/todo_bloc/todo_bloc.dart';
import '../../model/user_data/user_data.dart';
import '../todo_add_delete_edit/delete_todo.dart';
import '../todo_add_delete_edit/edit_todo.dart';
import '../widgets/pop_up_date_widget.dart';

class TodoDetailsScreen extends StatefulWidget {
  final UserData userData;
  final String formatedDate;
  final int index;
  final String formatedDeadLine;
  final TodoBloc todoBloc;

  const TodoDetailsScreen({
    super.key,
    required this.userData,
    required this.formatedDate,
    required this.index,
    required this.formatedDeadLine,
    required this.todoBloc,
  });

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  final ScrollController scrollController = ScrollController();
  bool _showFab = true;
  bool isVisible = false;
  Future? popupTimer;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_toggleFabVisibility);
    checkImage();
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
    setState(
      () {
        isVisible = true;
      },
    );

    popupTimer = Future.delayed(
      const Duration(seconds: 3),
      () {
        if (!mounted) return;
        setState(
          () {
            isVisible = false;
          },
        );
      },
    );
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

  Duration duration = const Duration(milliseconds: 300);
  File? image;

  void checkImage() {
    setState(
      () {
        if (widget.userData.image != null &&
            widget.userData.image!.isNotEmpty) {
          image = File(widget.userData.image!);
        } else {
          image = null;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.status == TodoStatus.success) {
            if (widget.index >= 0 && widget.index < state.userData!.length) {
              final updatedUserData = state.userData![widget.index];
              setState(
                () {
                  widget.userData.title = updatedUserData.title;
                  widget.userData.description = updatedUserData.description;
                  widget.userData.image = updatedUserData.image;
                  widget.userData.deadline =
                      updatedUserData.deadline ?? widget.userData.deadline;
                  checkImage();
                },
              );
            }
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
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            enableFeedback:
                                widget.userData.deadline != null ? true : false,
                            onTap: () {
                              widget.userData.deadline != null
                                  ? togglePopup()
                                  : null;
                            },
                            child: Image.asset(
                              "icons/clock.png",
                              width: 26,
                              height: 26,
                              color: widget.userData.deadline != null
                                  ? Colors.black
                                  : Colors.grey,
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
                                  return BlocProvider.value(
                                    value: widget.todoBloc,
                                    child: EditTodo(
                                      userData: widget.userData,
                                      index: widget.index,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              "icons/edit.png",
                              width: 26,
                              height: 26,
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
                                    todoBloc: widget.todoBloc,
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              "icons/trash.png",
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.sp),
                  Text(
                    widget.userData.title?.toUpperCase() ?? "",
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
                          widget.userData.description ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "Body",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        if (image != null)
                          Container(
                            alignment: Alignment.center,
                            height: 350.sp,
                            child: Image.file(image!),
                          )
                        else
                          const SizedBox(height: 1),
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
