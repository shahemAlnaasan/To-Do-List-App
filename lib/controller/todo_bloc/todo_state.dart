part of 'todo_bloc.dart';

enum TodoStatus { loading, success, error, editSuccess }

class TodoState extends Equatable {
  final TodoStatus status;
  final List<UserData>? userData;
  final String message;

  const TodoState({
    this.status = TodoStatus.loading,
    this.message = '',
    this.userData = const [],
  });

  TodoState copyWith({
    final TodoStatus? status,
    final String? message,
    final List<UserData>? userData,
  }) {
    return TodoState(
      status: status ?? this.status,
      message: message ?? this.message,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object?> get props => [userData, status, message];
}
