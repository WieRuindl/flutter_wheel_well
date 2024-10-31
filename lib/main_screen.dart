import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wheel_well/life_quality_test/question.dart';
import 'package:wheel_well/test_screen.dart';
import 'package:wheel_well/wheel_of_life.dart';
import 'dart:html' as html;

class MainScreen extends StatefulWidget {
  final Map<String, List<Question>> questionsByCategory;
  const MainScreen({super.key, required this.questionsByCategory});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final defaultData = [
    { "category": "Career and Professional Growth", "value": 0.35 },
    { "category": "Contribution and Community Impact", "value": 0.8 },
    { "category": "Emotional Well-Being", "value": 0.55 },
    { "category": "Environment and Living Space", "value": 0.1 },
    { "category": "Financial Stability", "value": 0.75 },
    { "category": "Health and Wellness", "value": 0.92 },
    { "category": "Personal Growth and Development", "value": 0.6 },
    { "category": "Recreation and Fun", "value": 0.8 },
    { "category": "Relationships and Social Life", "value": 0.1 },
    { "category": "Spirituality and Meaning", "value": 0.55 }
  ];

  final data = [];

  @override
  Widget build(BuildContext context) {

    if (data.isEmpty) {
      final dataFromStorage = html.window.localStorage["saved_data_flutter_wheel_of_life"];
      if (dataFromStorage == null) {
        print("No data found :(");
        data.addAll(defaultData);
      } else {
        print("Data found :)");
        var decoded = jsonDecode(dataFromStorage);
        data.addAll(decoded);
      }
    }

    final Map<String, double> scores = {};
    for (var entry in data) {
      scores.putIfAbsent(entry["category"]!.toString(), () => double.parse(entry["value"]!.toString()));
    }

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.3,
          height: MediaQuery.of(context).size.width*0.3,
          child: WheelOfLife(scores: scores,)
        ),
        const SizedBox(height: 30,),
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.greenAccent),
          ),
          onPressed: () async {
            Map<String, double>? newData = await showDialog<Map<String, double>>(
                context: context,
                builder: (context) => TestScreen(questionsByCategory: widget.questionsByCategory,)
            );
            if (newData != null) {
              setState(() {
                data.clear();
                data.addAll(newData.entries.map((e) => {"category": e.key, "value": e.value}).toList());
                html.window.localStorage["saved_data_flutter_wheel_of_life"] = jsonEncode(data).toString();
              });
            }
          },
          child: const Text("Take Test"),
        )
      ],
    );
  }
}
