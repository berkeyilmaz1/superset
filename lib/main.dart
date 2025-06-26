import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/app_nav_bar/app_nav_bar.dart';
import 'package:superset/constants/string_constants.dart';
import 'package:superset/nav_cubit.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appName,
      home: BlocProvider(
        create: (context) => NavCubit(),
        child: const AppNavBar(),
      ),
    );
  }
}
