import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
  print("d");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CleanLoginPage(),
    );
  }
}