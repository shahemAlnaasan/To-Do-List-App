part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends AuthEvent {
  final UserInfo userInfo;

  const SignupEvent({
    required this.userInfo,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends AuthEvent {
  final String email;

  const LogoutEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class ChangePasswordEvent extends AuthEvent {
  final String email;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordEvent({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

class CheckAuhtStatusEvent extends AuthEvent {}
