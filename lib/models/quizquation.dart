class QuizQuestion {
  QuizQuestion(this.text, this.answer);
  final String text;
  final List<String> answer;

  List<String> getSuffledAnswers() {
    final suffledanswers = List.of(answer);
    suffledanswers.shuffle();

    return suffledanswers;
  }
}
