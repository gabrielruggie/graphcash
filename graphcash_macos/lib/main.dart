import 'package:flutter/material.dart';
import 'package:graphcash_macos/pages/home.dart';
//import 'package:graphcash_macos/pages/ref1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
