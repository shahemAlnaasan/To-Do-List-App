import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../hive/hive_services_auth.dart';
import '../../model/user_info/user_info.dart';
import 'package:uuid/uuid.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final HiveServices hiveServices = HiveServices();

  AuthBloc() : super(const AuthState()) {
    on<SignupEvent>(onSignup);
    on<LoginEvent>(onLogin);
    on<ChangePasswordEvent>(onChangePassword);
    on<LogoutEvent>(onLogout);
    on<CheckAuhtStatusEvent>(onCheckAuhtStatus);
  }

  Future<void> onSignup(SignupEvent event, emit) async {
    if (event.userInfo.confirmPassword != event.userInfo.password) {
      emit(
        state.copyWith(
          status: AuthStatus.authError,
          message: "Passwords do not match",
        ),
      );
      return;
    }

    emit(state.copyWith(status: AuthStatus.authLoading));

    try {
      final result = await hiveServices.storeUserInfo(event.userInfo);

      if (result) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            userInfo: event.userInfo,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.authError,
          message: "User already exists.",
        ),
      );
    }
  }

  Future<void> onLogin(LoginEvent event, emit) async {
    emit(state.copyWith(status: AuthStatus.authLoading));
    try {
      final UserInfo? userInfo =
          await hiveServices.getUserInfo(event.email, event.password);
      if (userInfo != null) {
        if (checkPassword(event.password, userInfo.password)) {
          emit(
            state.copyWith(
              status: AuthStatus.authenticated,
              userInfo: userInfo,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: AuthStatus.authError,
              message: "Invalid email or password",
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.authError,
            message: "Invalid email or password",
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during login: $e");
      }
      emit(
        state.copyWith(
          status: AuthStatus.authError,
          message: "An error occurred while logging in",
        ),
      );
    }
  }

  Future<void> onLogout(LogoutEvent event, emit) async {
    emit(state.copyWith(status: AuthStatus.authLoading));

    try {
      final result = await hiveServices.logOut(event.email);

      if (result) {
        emit(state.copyWith(status: AuthStatus.unAuthenticated));
      } else {
        emit(state.copyWith(
            status: AuthStatus.authError,
            userInfo: null,
            message: "Unable to logout Please try again."));
      }
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.authError,
          message: "Unable to logout Please try again."));
    }
  }

  Future<void> onChangePassword(ChangePasswordEvent event, emit) async {
    emit(state.copyWith(status: AuthStatus.authLoading));

    if (event.newPassword != event.confirmPassword) {
      emit(
        state.copyWith(
          status: AuthStatus.authError,
          message: "New passwords do not match.",
        ),
      );
      return;
    }

    try {
      final result = await hiveServices.changePassword(
          event.email, event.oldPassword, event.newPassword);

      if (result) {
        emit(state.copyWith(
            status: AuthStatus.passwordChanged,
            message: "Password changed successfully."));
      } else {
        emit(state.copyWith(
            status: AuthStatus.authError,
            message:
                "Old password is incorrect or new password matches the old one."));
      }
    } catch (e) {
      if (e.toString().contains('Email does not exist')) {
        emit(state.copyWith(
            status: AuthStatus.authError, message: "Email does not exist."));
      } else {
        emit(state.copyWith(
            status: AuthStatus.authError,
            message: "An error occurred while changing the password."));
      }
    }
  }

  Future<void> onCheckAuhtStatus(CheckAuhtStatusEvent event, emit) async {
    try {
      final accessToken = await hiveServices.checkStoredToken();
      final email = await hiveServices.checkStoredEmail();

      if (accessToken != null) {
        final UserInfo? userInfo = await hiveServices.getUserInfoInit(email!);
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          userInfo: userInfo,
        ));
      } else {
        emit(state.copyWith(status: AuthStatus.unAuthenticated));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.unAuthenticated));
    }
  }

  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  bool checkPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }

  String generateAccessToken() {
    return const Uuid().v4();
  }
}
