import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/todo_bloc/todo_bloc.dart';
import 'package:todo_list_app/view/widgets/custom_icon_size.dart';

class FilterTodo extends StatefulWidget {
  const FilterTodo({super.key});

  @override
  State<FilterTodo> createState() => _FilterTodoState();
}

class _FilterTodoState extends State<FilterTodo> {
  int selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.sp),
      child: PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        color: Colors.white,
        position: PopupMenuPosition.under,
        iconSize: 24,
        icon: const SizedIcon(
          name: "icons/filter (1).png",
          color: Color(0xffF76C6A),
        ),
        onSelected: (value) {
          selectedValue = value;
          setState(() {});
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () {
              context.read<TodoBloc>().add(GetTodosEvent());
            },
            value: 1,
            child: SizedBox(
              width: 126.sp,
              child: Text(
                "All",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: selectedValue == 1
                      ? const Color(0xffF76C6A)
                      : Colors.black,
                  fontFamily: "Body",
                ),
              ),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              context.read<TodoBloc>().add(GetTodosByTimeEvent());
            },
            value: 2,
            child: Text(
              "By Time",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color:
                    selectedValue == 2 ? const Color(0xffF76C6A) : Colors.black,
                fontFamily: "Body",
              ),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              context.read<TodoBloc>().add(GetTodosByDeadLineEvent());
            },
            value: 3,
            child: Text(
              "DeadLine",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color:
                    selectedValue == 3 ? const Color(0xffF76C6A) : Colors.black,
                fontFamily: "Body",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
