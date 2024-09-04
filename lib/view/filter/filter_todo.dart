import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/view/widgets/custom_icon_size.dart';

class FilterTodo extends StatefulWidget {
  const FilterTodo({super.key});

  @override
  State<FilterTodo> createState() => _FilterTodoState();
}

class _FilterTodoState extends State<FilterTodo> {
  int selectedValue = 2;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      color: Colors.white,
      padding: EdgeInsets.only(right: 24.sp),
      position: PopupMenuPosition.under,
      iconSize: 24,
      icon: const SizedIcon(
        name: "icons/filter.png",
        color: Color(0xffF76C6A),
      ),
      onSelected: (value) {
        selectedValue = value;
        setState(() {});
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: SizedBox(
            width: 126.sp,
            child: Text(
              "All",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color:
                    selectedValue == 1 ? const Color(0xffF76C6A) : Colors.black,
                fontFamily: "Body",
              ),
            ),
          ),
        ),
        PopupMenuItem(
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
    );
  }
}
