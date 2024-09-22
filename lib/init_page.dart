import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/auth_bloc/auth_bloc.dart';
import 'controller/todo_bloc/todo_bloc.dart';
import 'view/screens/auth_screens/sign_in_screen.dart';
import 'view/screens/home_screen.dart';

class InitPage extends StatelessWidget {
  final AuthBloc authBloc;
  final TodoBloc todoBloc;
  const InitPage({super.key, required this.authBloc, required this.todoBloc});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: todoBloc,
                child: HomeScreen(
                  todoBloc: todoBloc,
                ),
              ),
            ),
          );
        } else if (state.status == AuthStatus.unAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: authBloc,
                child: SignInScreen(
                  todoBloc: todoBloc,
                ),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.status == AuthStatus.authLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xffF76C6A),
              ),
            );
          },
        ),
      ),
    );
  }
}
