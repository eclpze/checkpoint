import 'package:checkpoint/data/models/lessonModel.dart';

class Course {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final List<Lesson> lessons;
  double? progress;
  bool isActive;

  Course({required this.id, required this.title, required this.subtitle, required this.description, required this.imageUrl, required this.lessons, this.progress, this.isActive = false});

  int get totalLessons => lessons.length;

  String get formattedSubtitle => '$subtitle ($totalLessons занятий)';

  double get calculatedProgress {
    if (lessons.isEmpty) return 0.0;
    final completed = lessons.where((l) => l.isCompleted).length;
    return completed / lessons.length;
  }
}
