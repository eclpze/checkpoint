import 'dart:convert';
import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/data/courseData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseManager {
  static final CourseManager _instance = CourseManager._internal();

  factory CourseManager() => _instance;

  CourseManager._internal();

  List<Course>? _courses;
  static const String _key = 'courses_progress';

  Future<List<Course>> getCourses() async {
    if (_courses != null) return _courses!;

    _courses = CourseData.getAllCourses();

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);

    if (saved != null) {
      final Map<String, dynamic> progress = jsonDecode(saved);

      for (var course in _courses!) {
        if (progress.containsKey(course.id)) {
          final data = progress[course.id] as Map<String, dynamic>;
          course.isActive = data['isActive'] ?? false;
          course.progress = (data['progress'] as num?)?.toDouble();

          for (var lesson in course.lessons) {
            if (data['lessons'] != null) {
              final lessonData = data['lessons'][lesson.id];
              if (lessonData != null) {
                lesson.isCompleted = lessonData['completed'] ?? false;
              }
            }
          }
        }
      }
    }

    return _courses!;
  }

  Future<void> saveCourseProgress(Course course) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key) ?? '{}';
    final progress = jsonDecode(saved) as Map<String, dynamic>;

    progress[course.id] = {
      'isActive': course.isActive,
      'progress': course.progress,
      'lessons': {
        for (var lesson in course.lessons) lesson.id: {'completed': lesson.isCompleted},
      },
    };

    await prefs.setString(_key, jsonEncode(progress));
  }

  Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    _courses = null;
  }
}
