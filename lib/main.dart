import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list_app/controller/auth_bloc/auth_bloc.dart';
import 'package:todo_list_app/controller/todo_bloc/todo_bloc.dart';
import 'package:todo_list_app/view/home_page.dart';
import 'package:todo_list_app/view/init_page.dart';
import 'package:todo_list_app/controller/pop_up_bloc/pop_up_bloc.dart';
import 'package:todo_list_app/helper/bloc_observer.dart';
import 'package:todo_list_app/model/user_data/user_data.dart';
import 'package:todo_list_app/model/user_info/user_info.dart';
import 'package:todo_list_app/view/auth/sign_in_page.dart';
import 'package:todo_list_app/view/auth/sign_up_page.dart';
import 'package:todo_list_app/view/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserInfoAdapter());
  Hive.registerAdapter(UserDataAdapter());

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopUpBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckAuhtStatusEvent()),
        ),
        BlocProvider(create: (context) => TodoBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const InitPage(),
          routes: {
            "Signin": (context) => const SignIn(),
            "homePage": (context) => const HomePage(),
            "Signup": (context) => const SignUp(),
            "Profile": (context) => const ProfilePage(),
          },
        ),
      ),
    );
  }
}
