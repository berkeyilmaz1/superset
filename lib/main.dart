import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/app_initialize.dart';
import 'package:superset/features/app_nav_bar/app_nav_bar.dart';
import 'package:superset/features/app_nav_bar/cubit/nav_cubit.dart';
import 'package:superset/features/workout/cubit/workout_cubit.dart';
import 'package:superset/product/constants/string_constants.dart';
import 'package:superset/product/initialize/main_localization.dart';

Future<void> main() async {
  await AppInitialize.init();
  runApp(MainLocalization(child: const MainApp()));
}

final class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      title: StringConstants.appName,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavCubit(),
          ),
          BlocProvider(
            create: (context) => WorkoutCubit(),
          ),
        ],
        child: const AppNavBar(),
      ),
    );
  }
}

///TODO: bottom sheet kaldır, onun yerine yeni bir sayfa aç, +ya basıldığında divider'ın üstüne yeni exercise ekle en alta da buton olarak save workout ekle,
/// bunlar kullanıcının kayıtlı workoutlarında gözüksün, workout'ı kaydettiğinde firebase'e kaydet, firebase'den çektiğinde de listele
/// yeni günde select workout olsun ordan kayıtlılar gözüksün veya yeni workout seçebilsin
/// seçtiği workoutı da başlatabilsin,
