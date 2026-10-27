import 'package:flutter/foundation.dart';

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final int? progress;
  final int? required;
  final String conditionType;
  final int conditionValue;

  Achievement({required this.id, required this.title, required this.description, required this.iconPath, this.progress, this.required, required this.conditionType, required this.conditionValue});

  double get progressPercent => (required != null && progress != null) ? progress! / required! : 0.0;
}

class AchievementManager extends ChangeNotifier {
  static final AchievementManager _instance = AchievementManager._internal();

  factory AchievementManager() => _instance;

  AchievementManager._internal();

  // final Map<String, int> _progress = {};
  final Map<String, bool> _unlocked = {};
  final Map<String, DateTime?> _unlockDates = {};

  List<Achievement> getAchievements() {
    return [
      Achievement(id: 'first_course', title: 'Первый шаг', description: 'Завершите первый курс', iconPath: 'icons/resourses.svg', conditionType: 'courses_completed', conditionValue: 1),
      Achievement(id: 'five_courses', title: 'Усердный ученик', description: 'Завершите 5 курсов', iconPath: 'icons/resourses.svg', required: 5, conditionType: 'courses_completed', conditionValue: 5),
      Achievement(id: 'test_master', title: 'Мастер тестов', description: 'Пройдите 10 тестов на отлично', iconPath: 'icons/resourses.svg', required: 10, conditionType: 'tests_passed', conditionValue: 10),
      Achievement(id: 'hundred_lessons', title: 'Сто уроков', description: 'Пройдите 50 уроков', iconPath: 'icons/resourses.svg', required: 50, conditionType: 'lessons_completed', conditionValue: 50),
      Achievement(id: 'five_hundred_points', title: 'Полтысячи', description: 'Наберите 500 баллов', iconPath: 'icons/resourses.svg', required: 500, conditionType: 'total_points', conditionValue: 500),
    ];
  }

  bool isUnlocked(Achievement achievement, {required int completedCourses, required int completedLessons, required int completedTests, required int totalPoints}) {
    if (_unlocked[achievement.id] == true) return true;

    bool result = false;
    switch (achievement.conditionType) {
      case 'courses_completed':
        result = completedCourses >= achievement.conditionValue;
        break;
      case 'lessons_completed':
        result = completedLessons >= achievement.conditionValue;
        break;
      case 'tests_passed':
        result = completedTests >= achievement.conditionValue;
        break;
      case 'total_points':
        result = totalPoints >= achievement.conditionValue;
        break;
      default:
        result = false;
    }

    if (result) {
      _unlocked[achievement.id] = true;
      _unlockDates[achievement.id] = DateTime.now();
      notifyListeners();
    }
    return result;
  }

  int getProgress(Achievement achievement, {required int completedCourses, required int completedLessons, required int completedTests, required int totalPoints}) {
    if (_unlocked[achievement.id] == true) return achievement.required ?? achievement.conditionValue;

    switch (achievement.conditionType) {
      case 'courses_completed':
        return completedCourses;
      case 'lessons_completed':
        return completedLessons;
      case 'tests_passed':
        return completedTests;
      case 'total_points':
        return totalPoints;
      default:
        return 0;
    }
  }

  DateTime? getUnlockDate(String achievementId) => _unlockDates[achievementId];
}
