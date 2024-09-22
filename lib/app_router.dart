import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/auth_bloc/auth_bloc.dart';
import 'controller/todo_bloc/todo_bloc.dart';
import 'view/screens/auth_screens/change_password_screen.dart';
import 'view/screens/auth_screens/sign_in_screen.dart';
import 'view/screens/auth_screens/sign_up_screen.dart';
import 'view/screens/home_screen.dart';
import 'init_page.dart';
import 'view/screens/profile_screen.dart';
import 'view/screens/todo_details_screen.dart';

class AppRouter {
  final authBloc = AuthBloc();
  final todoBloc = TodoBloc();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authBloc..add(CheckAuhtStatusEvent()),
            child: InitPage(
              authBloc: authBloc,
              todoBloc: todoBloc,
            ),
          ),
        );

      case "Signin":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authBloc,
            child: SignInScreen(
              todoBloc: todoBloc,
            ),
          ),
        );

      case "Signup":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authBloc,
            child: const SignUpScreen(),
          ),
        );

      case "ChangePassword":
        final arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authBloc,
            child: ChangePasswordScreen(
              boxName: arg['boxName'],
            ),
          ),
        );

      case "homePage":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: todoBloc,
            child: HomeScreen(
              todoBloc: todoBloc,
            ),
          ),
        );

      case "Profile":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authBloc,
            child: const ProfileScreen(),
          ),
        );

      case "TodoDetailsScreen":
        final arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: todoBloc,
            child: TodoDetailsScreen(
              userData: arg['userData'],
              formatedDate: arg['formatedDate'],
              index: arg['index'],
              formatedDeadLine: arg['formatedDeadLine'],
              todoBloc: todoBloc,
            ),
          ),
        );

      default:
        return null;
    }
  }

  // void dispose() {
  //   authBloc.close();
  //   todoBloc.close();
  // }
}
