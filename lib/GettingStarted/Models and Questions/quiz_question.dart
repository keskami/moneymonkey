class QuizQuestion {
  const QuizQuestion(this.text, this.answers, this.correctAnswers);

  final String text;
  final List<String> answers;
  final List<String> correctAnswers;

  List<String> get shuffledAnswers {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
