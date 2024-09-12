import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/controller/hive/hive_services_todos.dart';
import 'package:todo_list_app/model/user_data/user_data.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  HiveServicesTodos hiveServicesTodos = HiveServicesTodos();
  TodoBloc() : super(const TodoState()) {
    on<GetTodosEvent>(onGetTodos);
    on<AddTodosEvent>(onAddTodos);
    on<DeleteTodosEvent>(onDeleteTodos);
    on<EditTodosEvent>(onEditTodos);
    on<GetTodosByTimeEvent>(onGetTodosByTime);
    on<GetTodosByDeadLineEvent>(onGetTodosByDeadLineEvent);
  }

  Future<void> onGetTodos(GetTodosEvent event, emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    try {
      String? userBoxName = await hiveServicesTodos.getUserBox();
      if (userBoxName == null) {
        return;
      }

      List<UserData> todosList = await hiveServicesTodos.getTodos(userBoxName);

      emit(state.copyWith(status: TodoStatus.success, userData: todosList));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, message: "catch$e"));
    }
  }

  Future<void> onGetTodosByTime(GetTodosByTimeEvent event, emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    try {
      String? userBoxName = await hiveServicesTodos.getUserBox();
      if (userBoxName == null) {
        return;
      }

      List<UserData> todosList = await hiveServicesTodos.getTodos(userBoxName);
      List<UserData> reversedTodosList = reverseTodos(todosList);

      emit(state.copyWith(
          status: TodoStatus.success, userData: reversedTodosList));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, message: "catch$e"));
    }
  }

  Future<void> onGetTodosByDeadLineEvent(
      GetTodosByDeadLineEvent event, emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    try {
      String? userBoxName = await hiveServicesTodos.getUserBox();
      if (userBoxName == null) {
        return;
      }

      List<UserData> todosList = await hiveServicesTodos.getTodos(userBoxName);
      List<UserData> todosByDeadLine = filterTodosByDeadLine(todosList);

      emit(state.copyWith(
          status: TodoStatus.success, userData: todosByDeadLine));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, message: "catch$e"));
    }
  }

  Future<void> onAddTodos(AddTodosEvent event, emit) async {
    try {
      await hiveServicesTodos.storeTodos(event.userData);
      add(GetTodosEvent());
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, message: "$e"));
    }
  }

  Future<void> onDeleteTodos(DeleteTodosEvent event, emit) async {
    emit(state.copyWith(status: TodoStatus.loading));
    final result = await hiveServicesTodos.deleteTodos(event.index);

    try {
      if (result) {
        emit(state.copyWith(status: TodoStatus.success));
        add(GetTodosEvent());
      }
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, message: "catch $e"));
    }
  }

  Future<void> onEditTodos(EditTodosEvent event, emit) async {
    final result =
        await hiveServicesTodos.editTodos(event.index, event.userData);

    try {
      if (result) {
        emit(state.copyWith(status: TodoStatus.editSuccess));
        add(GetTodosEvent());
      }
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, message: "catch $e"));
    }
  }

  List<UserData> reverseTodos(List<UserData> todos) {
    return todos.reversed.toList();
  }

  List<UserData> filterTodosByDeadLine(List<UserData> userData) {
    final filterdTodos =
        userData.where((userData) => userData.deadline != null).toList();

    filterdTodos.sort((a, b) => a.deadline!.compareTo(b.deadline!));

    return filterdTodos;
  }
}
