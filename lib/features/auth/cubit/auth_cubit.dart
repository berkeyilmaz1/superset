import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superset/features/auth/cubit/auth_state.dart';
import 'package:superset/product/initialize/localization/locale_keys.g.dart';
import 'package:superset/product/models/user.dart' as app_user;
import 'package:superset/product/service/firebase/firebase_service.dart';
import 'package:superset/product/service/firebase/firebase_service_manager.dart';

final class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
    : _firebaseService = FirebaseService(
        firebaseServiceManager: FirebaseServiceManager(),
      ),
      super(const AuthState(status: AuthStatus.initial)) {
    _initializeAuthState();
  }

  final FirebaseService _firebaseService;

  /// Initialize auth state and listen to auth changes
  void _initializeAuthState() {
    _firebaseService.authStateChanges.listen((User? user) {
      if (user != null) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            errorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.unauthenticated,
            user: null,
            errorMessage: null,
          ),
        );
      }
    });

    // Set initial state based on current user
    final currentUser = _firebaseService.currentUser;
    if (currentUser != null) {
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: currentUser,
        ),
      );
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    try {
      final userCredential = await _firebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential?.user != null) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: userCredential!.user,
            errorMessage: null,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: LocaleKeys.alerts_error.tr(),
        ),
      );
    }
  }

  /// Create user with email and password
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    try {
      final userCredential = await _firebaseService
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      if (userCredential?.user != null) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: userCredential!.user,
            errorMessage: null,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: LocaleKeys.alerts_error.tr(),
        ),
      );
    }
  }

  /// Create user with complete profile data
  Future<void> createUserWithCompleteProfile({
    required String email,
    required String password,
    required String displayName,
    String? gender,
    String? height,
    String? weight,
    DateTime? birthDate,
    String? goal,
    String? activityLevel,
    String? trainingExperience,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    try {
      final userCredential = await _firebaseService
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      if (userCredential?.user != null) {
        final firebaseUser = userCredential!.user!;

        // Update display name
        await firebaseUser.updateDisplayName(displayName);

        // Create complete user profile
        final appUser = app_user.User(
          uid: firebaseUser.uid,
          email: email,
          displayName: displayName,
          picture: null,
          gender: gender,
          height: height,
          weight: weight,
          birthDate: birthDate,
          goal: goal,
          activityLevel: activityLevel,
          trainingExperience: trainingExperience,
          premium: false,
          workouts: [],
        );

        // Save user data to Firestore
        await _firebaseService.saveUserData(appUser);

        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: firebaseUser,
            errorMessage: null,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: LocaleKeys.alerts_error.tr(),
        ),
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await _firebaseService.signOut();
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: LocaleKeys.alerts_failed_to_sign_out.tr(),
        ),
      );
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    try {
      await _firebaseService.sendPasswordResetEmail(email: email);
      emit(
        state.copyWith(
          status: state.status == AuthStatus.authenticated
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
          errorMessage: null,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: LocaleKeys.alerts_failed_to_reset_email.tr(),
        ),
      );
    }
  }

  /// Update password
  Future<void> updatePassword({required String newPassword}) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    try {
      await _firebaseService.updatePassword(newPassword: newPassword);
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          errorMessage: null,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: LocaleKeys.alerts_failed_to_update_password.tr(),
        ),
      );
    }
  }

  /// Delete user account
  Future<void> deleteUser() async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    try {
      await _firebaseService.deleteUser();
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          errorMessage: null,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: LocaleKeys.alerts_failed_to_delete_acc.tr(),
        ),
      );
    }
  }

  /// Clear error state
  void clearError() {
    if (state.status == AuthStatus.error) {
      emit(
        state.copyWith(
          status: _firebaseService.isSignedIn
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
          errorMessage: null,
        ),
      );
    }
  }

  /// Convert Firebase error codes to user-friendly messages
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return LocaleKeys.alerts_user_not_found.tr();
      case 'wrong-password':
        return LocaleKeys.alerts_wrong_password.tr();
      case 'email-already-in-use':
        return LocaleKeys.alerts_email_already_in_use.tr();
      case 'weak-password':
        return LocaleKeys.alerts_weak_password.tr();
      case 'invalid-email':
        return LocaleKeys.alerts_invalid_email.tr();
      case 'user-disabled':
        return LocaleKeys.alerts_user_disabled.tr();
      case 'too-many-requests':
        return LocaleKeys.alerts_too_many_requests.tr();
      case 'operation-not-allowed':
        return LocaleKeys.alerts_operation_not_allowed.tr();
      case 'requires-recent-login':
        return LocaleKeys.alerts_requires_recent_login.tr();
      default:
        return LocaleKeys.alerts_error.tr();
    }
  }
}
