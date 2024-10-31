import 'package:wheel_well/life_quality_test/answer.dart';

class Question {
  final String text;
  final List<Answer> answers;
  final int maxPossibleScore;

  Question({required this.text, required this.answers, required this.maxPossibleScore,});
}