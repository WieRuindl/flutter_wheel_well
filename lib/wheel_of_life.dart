import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WheelOfLife extends StatelessWidget {
  final Map<String, double> scores;

  const WheelOfLife({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      RadarChartData(
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, decoration: TextDecoration.none,
        ),
        radarShape: RadarShape.circle,
        dataSets: [
          RadarDataSet(
            fillColor: Colors.blue.withOpacity(0.5),
            borderColor: Colors.blue,
            entryRadius: 3,
            dataEntries: scores.values.map((score) => RadarEntry(value: score)).toList(),
          ),
          RadarDataSet(
            fillColor: Colors.white.withOpacity(0.0),
            borderColor: Colors.white.withOpacity(0.0),
            entryRadius: 3,
            dataEntries: [0.0, 0.1, 0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9, 1.0]
                .map((score) => RadarEntry(value: score))
                .toList(),
          ),
        ],
        tickCount: 10,
        ticksTextStyle: const TextStyle(color: Colors.grey, fontSize: 10),
        radarBackgroundColor: Colors.greenAccent,
        radarBorderData: const BorderSide(color: Colors.grey),
        tickBorderData: const BorderSide(color: Colors.grey),
        gridBorderData: const BorderSide(color: Colors.grey),
        titlePositionPercentageOffset: 0.28,
        getTitle: (index, angle) => RadarChartTitle(
          text: scores.keys.toList()[index],
        ),
      ),
    );
  }
}
