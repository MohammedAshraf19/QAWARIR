import 'package:flutter/material.dart';
import 'package:qawarir/modules/login_screen.dart';
import 'package:qawarir/modules/splash/splash_screen.dart';
import 'package:qawarir/shared/style/theme_manager.dart';
import 'modules/signup_screen.dart';

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
      home: const LoginScreen(),
    );
  }
}
