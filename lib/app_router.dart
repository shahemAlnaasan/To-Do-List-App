import 'package:flutter/material.dart';

import 'package:todo_list_app/controller/auth_bloc/auth_bloc.dart';
import 'package:todo_list_app/controller/todo_bloc/todo_bloc.dart';
import 'package:todo_list_app/view/screens/auth_screens/change_password_screen.dart';
import 'package:todo_list_app/view/screens/auth_screens/sign_in_screen.dart';
import 'package:todo_list_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:todo_list_app/view/screens/home_screen.dart';
import 'package:todo_list_app/init_page.dart';
import 'package:todo_list_app/view/screens/profile_screen.dart';
import 'package:todo_list_app/view/screens/todo_details_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => InitPage(),
        );

      case "Signin":
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );

      case "Signup":
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );

      case "Profile":
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      case "homePage":
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case "ChangePassword":
        final arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ChangePasswordScreen(
            boxName: arg['boxName'],
          ),
        );

      case "TodoDetailsScreen":
        final arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => TodoDetailsScreen(
            userData: arg['userData'],
            formatedDate: arg['formatedDate'],
            index: arg['index'],
            formatedDeadLine: arg['formatedDeadLine'],
          ),
        );

      default:
        return null;
    }
  }
}
