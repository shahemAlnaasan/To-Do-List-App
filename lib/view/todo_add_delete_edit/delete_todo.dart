import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/todo_bloc/todo_bloc.dart';
import '../widgets/custom_button.dart';

class DeleteTodo extends StatelessWidget {
  final int index;
  final TodoBloc todoBloc;
  const DeleteTodo({super.key, required this.index, required this.todoBloc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.sp,
      height: 160.sp,
      child: Column(
        children: [
          CustomButton(
            onTap: () {
              todoBloc.add(DeleteTodosEvent(index: index));
              Navigator.pop(context);
              Navigator.pop(context);
            },
            title: "Delete TODO",
            color: Colors.white,
            textColor: const Color(0xffF76C6A),
          ),
          SizedBox(height: 16.sp),
          CustomButton(
            onTap: () {
              Navigator.pop(context);
            },
            title: "Cancle",
            color: Colors.white,
            textColor: Colors.green,
          )
        ],
      ),
    );
  }
}
