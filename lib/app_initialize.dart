import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:superset/firebase_options.dart';

final class AppInitialize {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
