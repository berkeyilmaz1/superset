import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:superset/features/app_nav_bar/app_nav_bar.dart';
import 'package:superset/features/explore/view/explore_view.dart';
import 'package:superset/features/workout/view/workout_view.dart';
import 'package:superset/product/initialize/localization/locale_keys.g.dart';

mixin AppNavBarMixin on State<AppNavBar> {
  final List<NavigationDestination> destinations = [
    NavigationDestination(
      icon: const Icon(Icons.home_rounded),
      label: LocaleKeys.nav_bar_workouts.tr(),
    ),
    NavigationDestination(
      icon: const Icon(Icons.explore_rounded),
      label: LocaleKeys.nav_bar_explore.tr(),
    ),
    NavigationDestination(
      icon: const Icon(Icons.person_rounded),
      label: LocaleKeys.nav_bar_Body.tr(),
    ),
  ];

  final List<Widget> pages = const [
    WorkoutView(),
    ExploreView(),
    Center(child: Text('Body')),
  ];
}
