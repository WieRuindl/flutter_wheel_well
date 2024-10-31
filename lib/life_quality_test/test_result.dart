class TestResult {
  final Map<String, double> _scores = {};

  Map<String, double> get scores => _scores;
  void addScore(String lifeArea, double score) {
    _scores[lifeArea] = score;
  }
}