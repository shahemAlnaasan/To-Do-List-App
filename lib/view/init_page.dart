import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/controller/auth_bloc/auth_bloc.dart';
import 'package:todo_list_app/view/auth/sign_in_page.dart';
import 'package:todo_list_app/view/home_page.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (state.status == AuthStatus.unAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()),
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
