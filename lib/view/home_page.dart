import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/view/filter/filter_todo.dart';
import 'package:todo_list_app/view/todo_add_delete_edit/add_todo.dart';
import 'package:todo_list_app/view/widgets/custom_icon_size.dart';
import 'package:todo_list_app/view/widgets/todo_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: ListView(
          children: [
            SizedBox(height: 15.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24.sp),
                  child: Row(
                    children: [
                      const SizedIcon(
                          name: "icons/Union (1).png",
                          color: Color(0xffF76C6A)),
                      SizedBox(width: 9.sp),
                      Text(
                        "LIST OF TODO",
                        style: TextStyle(
                            fontFamily: "HeadLine",
                            color: const Color(0xffF76C6A),
                            fontSize: 32.sp),
                      ),
                    ],
                  ),
                ),
                const FilterTodo(),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.sp),
              child: const TodoBox(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            showModalBottomSheet(
              barrierColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddTodo();
              },
            );
          },
          child: Image.asset(
            "icons/plus-circle.png",
            width: 72.sp,
            height: 72.sp,
          ),
        ));
  }
}
