import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'initial.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyAppLanch());
}

void runApp(MyAppLanch myAppLanch) {}

class Firebase {
  static initializeApp() {}
}

class WidgetsFlutterBinding {
  static void ensureInitialized() {}
}
