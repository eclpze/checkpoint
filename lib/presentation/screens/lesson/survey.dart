import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/data/models/lessonModel.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class SurveyScreen extends StatefulWidget {
  final Course course;
  final Lesson lesson;

  const SurveyScreen({super.key, required this.lesson, required this.course});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  int? selectedAnswer;
  int currentQuestionIndex = 0;
  final List<int?> _answers = [];

  @override
  void initState() {
    super.initState();
    _answers.addAll(List.filled(widget.lesson.surveyQuestions!.length, null));
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.lesson.surveyQuestions![currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: ps(h: 20, v: 30),
            child: Row(
              children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: arrowLeft()),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    widget.lesson.title,
                    style: AppTypography.text1Semibold.copyWith(color: AppColors.dark, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
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
                            child: LinearProgressIndicator(value: (currentQuestionIndex + 1) / widget.lesson.surveyQuestions!.length, backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation<Color>(AppColors.active)),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.fw),
                      Text('${currentQuestionIndex + 1}/${widget.lesson.surveyQuestions!.length}', style: AppTypography.text3Meduim.copyWith(color: AppColors.dark)),
                    ],
                  ),
                  SizedBox(height: 24.fh),
                  Text(question.questionText, style: AppTypography.text2Semibold.copyWith(color: AppColors.dark)),
                  SizedBox(height: 24.fh),
                  ...List.generate(question.options.length, (index) {
                    final isSelected = _answers[currentQuestionIndex] == index;
                    return GestureDetector(
                      onTap: () => setState(() => _answers[currentQuestionIndex] = index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: pa(16),
                        decoration: BoxDecoration(color: isSelected ? Color(0xffB1F4B5).withOpacity(0.5) : Colors.grey.shade200, borderRadius: BorderRadius.circular(14.28.r)),
                        child: Row(
                          children: [
                            Container(
                              width: 32.fw,
                              height: 32.fh,
                              decoration: BoxDecoration(color: isSelected ? Color(0xff2AE92D).withOpacity(0.5) : Color(0xffC4C4C4), shape: BoxShape.circle),
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
                      onPressed: _answers[currentQuestionIndex] != null
                          ? () {
                              if (currentQuestionIndex < widget.lesson.surveyQuestions!.length - 1) {
                                setState(() => currentQuestionIndex++);
                              } else {
                                showResult();
                              }
                            }
                          : null,
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
                      child: Text(currentQuestionIndex == widget.lesson.surveyQuestions!.length - 1 ? 'Завершить' : 'Далее', style: AppTypography.text2Semibold.copyWith(color: AppColors.white)),
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

  void showResult() {
    final scores = [0, 0, 0, 0];
    for (final answer in _answers) {
      if (answer != null && answer < 4) scores[answer]++;
    }

    final resultIndex = scores.indexOf(scores.reduce((a, b) => a > b ? a : b));

    final competencies = [
      // Разработка и дизайн
      'Разработка мобильных приложений\nЦифровой дизайн\nПрограммные решения для бизнеса\nПрограммно-проектное управление',
      // Игры, VR/AR, 3D
      'Разработка компьютерных игр\nРазработка виртуальной реальности\nРазработка виртуальных миров\nМоушн-дизайн\n3D-моделирование для игр',
      // Данные и ИИ
      'Машинное обучение и большие данные\nНейросети и большие данные\nСпециалист по анализу данных (BI-аналитик)\nПроектирование нейроинтерфейсов\nЦифровой двойник пациента',
      // Инфраструктура и робототехника
      'Сетевое и системное администрирование\nОблачные технологии\nМобильная робототехника\nПромышленная робототехника\nТехнологии ИИ в беспилотных системах\nПротиводействие БПЛА',
    ];

    final titles = ['📱 Разработка и дизайн', '🎮 Игры, VR/AR, 3D', '📊 Данные и ИИ', '🖥️ Инфраструктура и робототехника'];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text('🎯 Твоя рекомендация', style: AppTypography.title2Bold, textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              titles[resultIndex],
              style: AppTypography.text2Semibold.copyWith(color: AppColors.dark),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.fh),
            Text(
              competencies[resultIndex],
              style: AppTypography.textMeduim.copyWith(color: AppColors.dark, height: 1.4),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.fh),
            Text(
              'Эти компетенции лучше всего соответствуют твоим интересам!',
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
}
