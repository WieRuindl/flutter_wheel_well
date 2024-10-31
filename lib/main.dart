import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wheel_well/file_reader.dart';
import 'package:wheel_well/life_quality_test/question.dart';
import 'package:wheel_well/test_screen.dart';

import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Map<String, List<Question>> questionsByCategory = await FileReader.loadQuestions();
  runApp(MyApp(questionsByCategory: questionsByCategory));
}

class MyApp extends StatelessWidget {
  final Map<String, List<Question>> questionsByCategory;

  const MyApp({super.key, required this.questionsByCategory});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(questionsByCategory: questionsByCategory),
    );
  }
}
