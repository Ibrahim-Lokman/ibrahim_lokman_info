import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ibrahim_lokman_info/screens/resume_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ibrahim Lokman Resume',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: ResumeScreen(isDarkMode: _isDarkMode, toggleTheme: toggleTheme),
    );
  }
}
