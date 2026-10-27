import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/presentation/screens/achievement.dart';
import 'package:checkpoint/presentation/screens/home.dart';
import 'package:checkpoint/presentation/screens/profile.dart';
import 'package:checkpoint/presentation/screens/search.dart';
import 'package:flutter/material.dart';

List<String> imageOnboardList = ['images/onboard1.png', 'images/onboard2.png', 'images/onboard3.png'];

List<String> titleOnboardList = ['Учись без стресса', 'Всего 15 минут в день', 'Сохраняй прогресс'];

List<String> textOnboardList = ['Большие цели начинаются с малого', 'Выделяй немного времени каждый день', ' Отслеживай свой уровень и двигайся вперёд'];

List<String> icons = ['icons/edit-name.svg', 'icons/protect.svg', 'icons/save.svg', 'icons/comments.svg', 'icons/setting.svg'];
List<String> titles = ['Изменение профиля', 'Безопасность', 'Политика приложения', 'Поддержка', 'О приложении'];

List<Widget> widgetOptions = <Widget>[HomeScreen(), AchievementsScreen(), SearchScreen(), ProfileScreen()];

late List<Course> allCourses;

List<Course> get activeCourses => allCourses.where((c) => c.isActive).toList();
