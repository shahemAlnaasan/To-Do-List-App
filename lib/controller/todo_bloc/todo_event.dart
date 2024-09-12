part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodosEvent extends TodoEvent {
  final UserData userData;

  const AddTodosEvent({required this.userData});

  @override
  List<Object> get props => [userData];
}

class GetTodosEvent extends TodoEvent {}

class EditTodosEvent extends TodoEvent {
  final int index;
  final UserData userData;

  const EditTodosEvent({required this.index, required this.userData});

  @override
  List<Object> get props => [index, userData];
}

class DeleteTodosEvent extends TodoEvent {
  final int index;

  const DeleteTodosEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class GetTodosByTimeEvent extends TodoEvent {}

class GetTodosByDeadLineEvent extends TodoEvent {}
