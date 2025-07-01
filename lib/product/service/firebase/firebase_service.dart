import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superset/product/initialize/localization/locale_keys.g.dart';
import 'package:superset/product/models/user.dart' as app_user;
import 'package:superset/product/service/firebase/firebase_service_manager.dart';

final class FirebaseService {
  FirebaseService({required FirebaseServiceManager firebaseServiceManager})
    : firebaseAuth = firebaseServiceManager.firebaseAuth,
      firebaseFirestore = firebaseServiceManager.firebaseFirestore;

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      // Handle other errors
      throw Exception(
        LocaleKeys.service_alerts_failed_to_create_user.tr(),
      );
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      // Handle other errors
      throw Exception(
        LocaleKeys.service_alerts_failed_to_sign_in.tr(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(
        LocaleKeys.service_alerts_failed_to_sign_out.tr(),
      );
    }
  }

  /// Get the current authenticated user
  User? get currentUser => firebaseAuth.currentUser;

  /// Check if user is currently signed in
  bool get isSignedIn => currentUser != null;

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  /// Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      throw Exception(
        LocaleKeys.service_alerts_failed_to_send_password_reset.tr(),
      );
    }
  }

  /// Update user password
  Future<void> updatePassword({required String newPassword}) async {
    try {
      final user = currentUser;
      if (user == null) {
        throw Exception(LocaleKeys.service_alerts_no_user_signed_in.tr());
      }
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      throw Exception(
        LocaleKeys.service_alerts_failed_to_update_password.tr(),
      );
    }
  }

  /// Delete current user account
  Future<void> deleteUser() async {
    try {
      final user = currentUser;
      if (user == null) {
        throw Exception(LocaleKeys.service_alerts_no_user_signed_in.tr());
      }
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      throw Exception(
        LocaleKeys.service_alerts_failed_to_delete_user.tr(),
      );
    }
  }

  /// Save user data to Firestore
  Future<void> saveUserData(app_user.User user) async {
    try {
      final userRef = firebaseFirestore.collection('users').doc(user.uid);
      await userRef.set(user.toJson());
    } catch (e) {
      throw Exception(
        LocaleKeys.service_alerts_failed_to_save_user_data.tr(),
      );
    }
  }

  /// Get user data from Firestore
  Future<app_user.User?> getUserData(String uid) async {
    try {
      final userDoc = await firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();
      if (userDoc.exists && userDoc.data() != null) {
        return app_user.User.fromJson(userDoc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception(
        LocaleKeys.service_alerts_failed_to_get_user_data.tr(),
      );
    }
  }

  /// Update user data in Firestore
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      final userRef = firebaseFirestore.collection('users').doc(uid);
      await userRef.update(data);
    } catch (e) {
      throw Exception(
        LocaleKeys.service_alerts_failed_to_update_user_data.tr(),
      );
    }
  }
}
