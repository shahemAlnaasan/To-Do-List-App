part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unAuthenticated,
  authError,
  authLoading,
  passwordChanged,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserInfo? userInfo;
  final String message;

  const AuthState({
    this.status = AuthStatus.unAuthenticated,
    this.message = '',
    this.userInfo,
  });

  AuthState copyWith({
    final AuthStatus? status,
    final String? message,
    final UserInfo? userInfo,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  List<Object?> get props => [userInfo, status, message];
}
