import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list_app/controller/bloc/pop_up_bloc.dart';
import 'package:todo_list_app/helper/bloc_observer.dart';
import 'package:todo_list_app/model/todo_items_model.dart';
import 'package:todo_list_app/view/home_page.dart';
import 'package:todo_list_app/view/auth/change_password.dart';
import 'package:todo_list_app/view/auth/sign_in_page.dart';
import 'package:todo_list_app/view/auth/sign_up_page.dart';
import 'package:todo_list_app/view/profile_page.dart';
import 'package:todo_list_app/view/todo_detail.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(TodoItmesAdapter());
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
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      ),
    );
  }
}
