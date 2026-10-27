import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/data/models/lessonModel.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class TextLessonScreen extends StatefulWidget {
  final Lesson lesson;
  final Course course;

  const TextLessonScreen({super.key, required this.lesson, required this.course});

  @override
  State<TextLessonScreen> createState() => _TextLessonScreenState();
}

class _TextLessonScreenState extends State<TextLessonScreen> {
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
                GestureDetector(onTap: () => Navigator.pop(context, true), child: arrowLeft()),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    widget.lesson.title,
                    style: AppTypography.text1Semibold.copyWith(color: AppColors.dark, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                SizedBox(width: 40.fw),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: ps(h: 20),
              child: Column(
                children: [
                  SizedBox(height: 10.fh),
                  Text(widget.lesson.content ?? '', style: AppTypography.text2Meduim.copyWith(color: AppColors.dark)),
                  SizedBox(height: 35.fh),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
