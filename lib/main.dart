import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/ui/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAntLCbyEB3qPL9fyzrd9P3Ff_JP5x-l8o",
          appId: "1:390273009411:web:e758fdb95322b3bf0f8b36",
          messagingSenderId: "390273009411",
          projectId: "haven7-15569"));
  runApp(const Websitelayout());
}
