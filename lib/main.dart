import 'package:flutter/material.dart';
import 'package:qawarir/layout/qawarir_layout.dart';
import 'package:qawarir/modules/login/login_screen.dart';
import 'package:qawarir/modules/on_boarding/on_boarding_screen.dart';
import 'package:qawarir/modules/splash/splash_screen.dart';
import 'package:qawarir/shared/style/theme_manager.dart';
import 'modules/register/Register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QAWARIR',
      theme: myTheme(),
      home: const SplashScreen(),
    );
  }
}
