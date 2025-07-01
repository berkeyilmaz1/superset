import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  initial,
  loading,
  unauthenticated,
  authenticated,
  error,
}

final class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.user,
  });

  final AuthStatus status;
  final String? errorMessage;
  final User? user;

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    user,
  ];

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
