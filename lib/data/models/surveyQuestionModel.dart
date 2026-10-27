class SurveyQuestion {
  final String id;
  final String questionText;
  final List<String> options;
  final String? hint;

  SurveyQuestion({required this.id, required this.questionText, required this.options, this.hint});
}
