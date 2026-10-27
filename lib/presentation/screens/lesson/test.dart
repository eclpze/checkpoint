import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/data/models/lessonModel.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class TestScreen extends StatefulWidget {
  final Lesson lesson;
  final Course course;

  const TestScreen({super.key, required this.lesson, required this.course});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int? selectedAnswer;
  bool isChecked = false;
  int currentQuestionIndex = 0;
  int correctCount = 0;

  void _showResultDialog() {
    final total = widget.lesson.questions!.length;
    final percent = ((correctCount / total) * 100).round();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text(
          percent >= 80
              ? '🎉 Отлично!'
              : percent >= 50
              ? ' Хороший результат'
              : ' Нужно повторить',
          style: AppTypography.title2Bold,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$correctCount из $total правильных ответов',
              style: AppTypography.text2Semibold.copyWith(color: AppColors.dark),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.fh),
            Text(
              'Успешность: $percent%',
              style: AppTypography.textMeduim.copyWith(color: AppColors.light_grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.active,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
              ),
              child: Text('Вернуться к курсу', style: AppTypography.text2Semibold.copyWith(color: AppColors.white)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.lesson.questions![currentQuestionIndex];

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
                  width: MediaQuery.of(context).size.width * 0.6,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4.fh,
                          decoration: BoxDecoration(color: AppColors.light, borderRadius: BorderRadius.circular(6.r)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: LinearProgressIndicator(value: (currentQuestionIndex + 1) / widget.lesson.questions!.length, backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation<Color>(AppColors.active)),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.fw),
                      Text('${currentQuestionIndex + 1}/${widget.lesson.questions!.length}', style: AppTypography.text3Meduim.copyWith(color: AppColors.dark)),
                    ],
                  ),
                  SizedBox(height: 24.fh),
                  Text(question.questionText, style: AppTypography.text2Semibold.copyWith(color: AppColors.dark)),
                  SizedBox(height: 24.fh),
                  ...List.generate(question.options.length, (index) {
                    Color bgColor;
                    if (isChecked) {
                      if (index == question.correctAnswerIndex) {
                        bgColor = Color(0xffB1F4B5).withOpacity(0.5);
                      } else if (index == selectedAnswer && index != question.correctAnswerIndex) {
                        bgColor = Color(0xffF5A6A7).withOpacity(0.5);
                      } else {
                        bgColor = Colors.grey.shade200;
                      }
                    } else {
                      bgColor = selectedAnswer == index ? Color(0xffBBEFFD) : Colors.grey.shade200;
                    }
                    return GestureDetector(
                      onTap: isChecked ? null : () => setState(() => selectedAnswer = index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: pa(16),
                        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(14.28.r)),
                        child: Row(
                          children: [
                            Container(
                              width: 32.fw,
                              height: 32.fh,
                              decoration: BoxDecoration(
                                color: isChecked
                                    ? (index == question.correctAnswerIndex ? Color(0xff2AE92D).withOpacity(0.5) : (index == selectedAnswer ? Color(0xffE75151).withOpacity(0.5) : Color(0xffC4C4C4)))
                                    : (selectedAnswer == index ? Color(0xff5DCCEA).withOpacity(0.5) : Color(0xffC4C4C4)),
                                shape: BoxShape.circle,
                              ),
                              child: Center(child: Text('${index + 1}', style: AppTypography.text2Semibold)),
                            ),
                            SizedBox(width: 12.fw),
                            Expanded(
                              child: Text(question.options[index], style: AppTypography.text2Meduim.copyWith(color: AppColors.dark)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 32.fh),
                  SizedBox(
                    width: double.infinity,
                    height: 50.fh,
                    child: ElevatedButton(
                      onPressed: selectedAnswer == null
                          ? null
                          : () {
                              if (!isChecked) {
                                if (selectedAnswer == widget.lesson.questions![currentQuestionIndex].correctAnswerIndex) {
                                  correctCount++;
                                }
                                setState(() => isChecked = true);
                              } else if (currentQuestionIndex < widget.lesson.questions!.length - 1) {
                                setState(() {
                                  currentQuestionIndex++;
                                  selectedAnswer = null;
                                  isChecked = false;
                                });
                              } else {
                                _showResultDialog();
                              }
                            },
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor: AppColors.active,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                          ).copyWith(
                            overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.pressed)) {
                                return Colors.transparent;
                              }
                              return Colors.transparent;
                            }),
                            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                              return AppColors.active;
                            }),
                          ),
                      child: Text(isChecked && currentQuestionIndex == widget.lesson.questions!.length - 1 ? 'Завершить' : 'Проверить', style: AppTypography.text2Semibold.copyWith(color: AppColors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
