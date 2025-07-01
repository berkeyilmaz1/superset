import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final class FirebaseServiceManager {
  // Factory constructor to return the same instance
  factory FirebaseServiceManager() {
    return _instance;
  }

  FirebaseServiceManager._internal();

  static final FirebaseServiceManager _instance =
      FirebaseServiceManager._internal();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
}
