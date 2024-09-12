import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/controller/todo_bloc/todo_bloc.dart';
import 'package:todo_list_app/model/date_model.dart';
import 'package:todo_list_app/view/filter/filter_todo.dart';
import 'package:todo_list_app/view/todo_add_delete_edit/add_todo.dart';
import 'package:todo_list_app/view/todo_details_page.dart';
import 'package:todo_list_app/view/widgets/custom_icon_size.dart';
import 'package:todo_list_app/view/widgets/todo_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TodoBloc>().add(GetTodosEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
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
            child: InkWell(
              child: const SizedIcon(
                name: "icons/settings (1).png",
              ),
              onTap: () {
                Navigator.of(context).pushNamed("Profile");
              },
            ),
          ),
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
                        name: "icons/Union (1).png", color: Color(0xffF76C6A)),
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
            padding: EdgeInsets.only(left: 24.sp, right: 24.sp, bottom: 10.sp),
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state.status == TodoStatus.loading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 0.3.sh,
                      ),
                      const CircularProgressIndicator(
                        color: Color(0xffF76C6A),
                      ),
                    ],
                  );
                } else if (state.status == TodoStatus.success) {
                  return state.userData!.isEmpty
                      ? Center(
                          heightFactor: 0.03.sh,
                          child: Text(
                            "Start adding your ToDos!",
                            style: TextStyle(
                                fontFamily: "Body",
                                fontSize: 15.sp,
                                color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.userData!.length,
                          itemBuilder: (context, i) {
                            String formatedDate = DateModel()
                                .formateDate(state.userData?[i].creatingDate);
                            String formatedDeadLine = DateModel()
                                .formateDate(state.userData?[i].deadline);
                            return InkWell(
                              child: TodoBox(
                                userData: state.userData![i],
                                formatedDate: formatedDate,
                                formatedDeadLine: formatedDeadLine,
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TodoDetail(
                                          userData: state.userData![i],
                                          formatedDate: formatedDate,
                                          index: i,
                                          formatedDeadLine: formatedDeadLine,
                                        )));
                              },
                            );
                          },
                        );
                } else {
                  return const Text("");
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 10000,
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
      ),
    );
  }
}
