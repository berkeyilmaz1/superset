import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/app_nav_bar/app_nav_bar_mixin.dart';
import 'package:superset/nav_cubit.dart';
import 'package:superset/nav_state.dart';

final class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> with AppNavBarMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, NavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state.currentIndex, children: pages),
          bottomNavigationBar: NavigationBar(
            destinations: destinations,
            onDestinationSelected: (int index) =>
                context.read<NavCubit>().changeIndex(index),
            selectedIndex: state.currentIndex,
          ),
        );
      },
    );
  }
}
