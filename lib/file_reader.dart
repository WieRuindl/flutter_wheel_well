import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wheel_well/life_quality_test/answer.dart';
import 'package:wheel_well/life_quality_test/question.dart';

abstract class FileReader {

  static Future<Map<String, List<Question>>> loadQuestions() async {
    var files = await loadFiles("categories.json");

    final Map<String, List<Question>> questionsByCategory = {};
    for (var i = 0; i < files.length; ++i) {
      var entry = await readFile(files[i]);
      questionsByCategory.addAll(entry);
    }

    return questionsByCategory;
  }

  static Future<List<String>> loadFiles(String fileName) async {
    final String response = await rootBundle.loadString(fileName);
    final data = jsonDecode(response);
    return List<String>.from(data['files']);
  }

  static Future<Map<String, List<Question>>> readFile(String fileName) async {
    final json = await jsonString(fileName);

    final categories = jsonDecode(json) as Map<String, dynamic>;
    final categoryName = categories["category"];
    final category = categories["questions"];

    final List<Question> questions = [];
    for (int i = 0; i < category.length; i++) {
      final answersJsonMap = category[i]["answers"];

      final List<Answer> answers = [];
      for (int j = 0; j < answersJsonMap.length; j++) {
        final answer = Answer(
          text: answersJsonMap[j]["text"],
          score: answersJsonMap[j]["score"],
        );
        answers.add(answer);
      }

      final question = Question(
        text: category[i]["text"],
        answers: answers,
        maxPossibleScore: category[i]["maxScore"],
      );

      questions.add(question);
    }

    return Map.of({categoryName: questions});
  }

  static Future<String> jsonString(String fileName) async {
    return await rootBundle.loadString('questions/$fileName');
  }
}