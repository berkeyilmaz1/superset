import 'package:flutter/material.dart';
import 'package:superset/features/app_nav_bar/app_nav_bar.dart';
import 'package:superset/features/workout/view/workout_view.dart';

mixin AppNavBarMixin on State<AppNavBar> {
  final List<NavigationDestination> destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_rounded),
      label: 'Workouts',
    ),
    NavigationDestination(
      icon: Icon(Icons.explore_rounded),
      label: 'Explore',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_rounded),
      label: 'Body',
    ),
  ];

  final List<Widget> pages = const [
    WorkoutView(),
    Center(child: Text('Explore')),
    Center(child: Text('Body')),
  ];
}
