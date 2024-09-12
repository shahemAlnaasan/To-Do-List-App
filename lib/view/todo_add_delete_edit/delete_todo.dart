import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/todo_bloc/todo_bloc.dart';
import 'package:todo_list_app/view/widgets/custom_button.dart';

class DeleteTodo extends StatelessWidget {
  final int index;
  const DeleteTodo({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.sp,
      height: 160.sp,
      child: Column(
        children: [
          CustomButton(
            onTap: () {
              context.read<TodoBloc>().add(DeleteTodosEvent(index: index));
              Navigator.of(context).pushNamedAndRemoveUntil(
                'homePage',
                (route) => false,
              );
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
