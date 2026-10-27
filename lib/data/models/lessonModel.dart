import 'package:checkpoint/data/models/questionModel.dart';
import 'package:checkpoint/data/models/surveyQuestionModel.dart';

class Lesson {
  final String id;
  final String title;
  final String duration;
  final String type;
  final int points;
  final String? videoUrl;
  final String? content;
  final List<Question>? questions;
  final List<SurveyQuestion>? surveyQuestions;

  bool isCompleted;
  bool isLocked;

  Lesson({required this.id, required this.title, required this.duration, required this.type, this.points = 10, this.videoUrl, this.content, this.questions, this.surveyQuestions, this.isCompleted = false, this.isLocked = false});
}
