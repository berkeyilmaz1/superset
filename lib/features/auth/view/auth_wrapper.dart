import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/features/app_nav_bar/app_nav_bar.dart';
import 'package:superset/features/auth/cubit/auth_cubit.dart';
import 'package:superset/features/auth/cubit/auth_state.dart';
import 'package:superset/features/auth/view/login_view.dart';
import 'package:superset/features/auth/view/profile_setup_view.dart';

final class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.initial:
          case AuthStatus.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          
          case AuthStatus.unauthenticated:
          case AuthStatus.error:
            return const LoginView();
          
          case AuthStatus.authenticated:
            if (state.user?.isProfileComplete == false) {
              return const ProfileSetupView();
            }
            return const AppNavBar();
        }
      },
    );
  }
}
