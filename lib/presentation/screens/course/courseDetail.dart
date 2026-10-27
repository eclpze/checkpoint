import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/data/models/lessonModel.dart';
import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/domain/userWallet.dart';
import 'package:checkpoint/presentation/screens/course/manager.dart';
import 'package:checkpoint/presentation/screens/lesson/survey.dart';
import 'package:checkpoint/presentation/screens/lesson/test.dart';
import 'package:checkpoint/presentation/screens/lesson/text.dart';
import 'package:checkpoint/presentation/screens/lesson/video.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: ps(h: 20, v: 30),
            child: Row(
              children: [
                GestureDetector(onTap: () => navToMainScreen(context), child: arrowLeft()),
                SizedBox(width: 20.fw),
                Expanded(
                  child: Padding(
                    padding: po(r: 40),
                    child: Text(
                      widget.course.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontWeight: FontWeight.w500, fontSize: 17.fh),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: ps(h: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180.fh,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                    ),
                    child: widget.course.imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(widget.course.imageUrl, fit: BoxFit.cover),
                          )
                        : Center(child: Icon(Icons.school, size: 60, color: Colors.grey.shade400)),
                  ),
                  SizedBox(height: 20.fh),
                  Text(widget.course.title, style: AppTypography.title2Bold.copyWith(color: AppColors.dark)),
                  SizedBox(height: 8.fh),
                  Text('${widget.course.totalLessons} занятий', style: AppTypography.text2Meduim.copyWith(color: AppColors.light_grey)),
                  SizedBox(height: 24.fh),
                  Padding(
                    padding: ps(h: 50),
                    child: Row(
                      children: [
                        tabItem('Занятия', 0),
                        SizedBox(width: 30.fw),
                        tabItem('Описание', 1),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.fh),
                  if (selectedTab == 0) ...lessonsList(),
                  if (selectedTab == 1) description(),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.fh),
        ],
      ),
    );
  }

  Widget tabItem(String title, int index) {
    final isActive = selectedTab == index;

    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 85.fw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: AppTypography.text2Semibold.copyWith(color: isActive ? AppColors.active : AppColors.light_grey)),
            SizedBox(height: 8.fh),
            if (isActive)
              Container(
                height: 3.fh,
                width: 85.fw,
                decoration: BoxDecoration(color: AppColors.active, borderRadius: BorderRadius.circular(10.r)),
              ),
          ],
        ),
      ),
    );
  }

  IconData getLessonIcon(Lesson lesson) {
    if (lesson.isLocked) return Icons.lock;
    if (lesson.isCompleted) return Icons.check;

    switch (lesson.type.toLowerCase()) {
      case 'video':
        return Icons.play_arrow;
      case 'text':
        return Icons.description;
      case 'test':
        return Icons.quiz;
      case 'survey':
        return Icons.poll;
      default:
        return Icons.play_arrow;
    }
  }

  Color getIconColor(Lesson lesson) {
    if (lesson.isLocked) {
      return AppColors.light_grey;
    }

    if (lesson.isCompleted) {
      return AppColors.white;
    }

    return AppColors.white;
  }

  Color getIconBackgroundColor(Lesson lesson) {
    if (lesson.isCompleted) {
      return AppColors.active;
    }

    if (lesson.isLocked) {
      return AppColors.light;
    }

    return AppColors.active.withOpacity(0.2);
  }

  List<Widget> lessonsList() {
    return widget.course.lessons.asMap().entries.map((entry) {
      final lesson = entry.value;

      return GestureDetector(
        onTap: () {
          if (!lesson.isLocked) {
            openLesson(lesson);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Container(
                width: 48.fw,
                height: 48.fh,
                decoration: BoxDecoration(color: getIconBackgroundColor(lesson), shape: BoxShape.circle),
                child: Icon(getLessonIcon(lesson), color: getIconColor(lesson), size: 24),
              ),
              SizedBox(width: 16.fw),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(lesson.title, style: AppTypography.text2Meduim.copyWith(color: lesson.isLocked ? AppColors.light_grey : AppColors.dark)),
                        ),
                      ],
                    ),
                    // SizedBox(height: 4.fh),
                    // Text(
                    //   lesson.duration,
                    //   style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey),
                    // ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 30.fw, color: lesson.isLocked ? AppColors.light_grey : AppColors.active),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget description() {
    return Text(widget.course.description, style: AppTypography.text2Meduim.copyWith(color: AppColors.dark));
  }

  Future<void> openLesson(Lesson lesson) async {
    if (!widget.course.isActive) {
      widget.course.isActive = true;
      await CourseManager().saveCourseProgress(widget.course);
    }

    bool? lessonCompleted = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // 👇 Обновлённая логика переключения экранов
          switch (lesson.type.toLowerCase()) {
            case 'video':
              return VideoLessonScreen(lesson: lesson, course: widget.course);
            case 'text':
              return TextLessonScreen(lesson: lesson, course: widget.course);
            case 'test':
              return TestScreen(lesson: lesson, course: widget.course);
            case 'survey':
              return SurveyScreen(lesson: lesson, course: widget.course);
            default:
              return VideoLessonScreen(lesson: lesson, course: widget.course);
          }
        },
      ),
    );

    if (lessonCompleted == true) {
      setState(() {
        lesson.isCompleted = true;
        widget.course.progress = widget.course.calculatedProgress;
      });

      await UserWallet().addPoints(lesson.points);
      await CourseManager().saveCourseProgress(widget.course);
    }
  }
}
