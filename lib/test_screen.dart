import 'package:flutter/material.dart';
import 'package:wheel_well/life_quality_test/question.dart';

class TestScreen extends StatefulWidget {

  final Map<String, List<Question>> questionsByCategory;

  const TestScreen({super.key, required this.questionsByCategory});

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {

  final Map<String, double> scores = {};

  int _currentCategoryIndex = 0;
  int _currentQuestionIndex = 0;
  int _myScoreForCurrentCategory = 0;
  int _maxPossibleScoreForCurrentCategory = 0;

  @override
  Widget build(BuildContext context) {
    var categories = widget.questionsByCategory.keys.toList();
    var category = categories[_currentCategoryIndex];
    List<Question> questions = widget.questionsByCategory[category]!;
    var question = questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...question.answers.map(
                (answer) => RadioListTile<dynamic>(
                  title: Text(answer.text),
                  value: {"score": answer.score.toString(), "maxScore": question.maxPossibleScore.toString()},
                  groupValue: -1,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _myScoreForCurrentCategory += int.parse(value["score"]);
                        _maxPossibleScoreForCurrentCategory += int.parse(value["maxScore"]);

                        if (_currentQuestionIndex < questions.length - 1) {
                          _currentQuestionIndex++;
                        } else {

                          scores[category] = _myScoreForCurrentCategory / _maxPossibleScoreForCurrentCategory;

                          _myScoreForCurrentCategory = 0;
                          _maxPossibleScoreForCurrentCategory = 0;

                          if (_currentCategoryIndex < categories.length - 1) {
                            _currentQuestionIndex = 0;
                            _currentCategoryIndex++;
                          } else {
                            return Navigator.pop(context, scores);
                          }
                        }
                      });
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}