import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/features/app_nav_bar/app_nav_bar.dart';
import 'package:superset/features/auth/cubit/auth_cubit.dart';
import 'package:superset/features/auth/cubit/auth_state.dart';
import 'package:superset/features/auth/view/sign_in_screen.dart';

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
            return const SignInScreen();
          case AuthStatus.error:
            return const SignInScreen();
          case AuthStatus.authenticated:
            return const AppNavBar();
        }
      },
    );
  }
}
