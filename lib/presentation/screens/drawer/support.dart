import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.fw, vertical: 30.fh),
            child: Row(
              children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: arrowLeft()),
                Spacer(),
                Text(
                  'Поддержка',
                  style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontWeight: FontWeight.w500, fontSize: 17.fh),
                ),
                Spacer(),
                SizedBox(width: 40.fw),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.fw),
              child: Column(
                children: [
                  SizedBox(height: 20.fh),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Частые вопросы', style: AppTypography.text2Semibold.copyWith(color: AppColors.dark)),
                  ),
                  SizedBox(height: 16.fh),
                  faqItem('Как сбросить прогресс курса?', 'Прогресс курса можно сбросить в настройках курса. Нажмите на три точки и выберите "Сбросить прогресс".'),
                  SizedBox(height: 12.fh),
                  faqItem('Как получить сертификат?', 'Сертификат выдаётся автоматически после прохождения всех уроков и тестов курса.'),
                  SizedBox(height: 12.fh),
                  faqItem('Как изменить email?', 'Email можно изменить в разделе "Изменение профиля" в настройках аккаунта.'),
                  SizedBox(height: 30.fh),
                  Container(
                    padding: EdgeInsets.all(20.fw),
                    decoration: BoxDecoration(color: AppColors.active.withOpacity(0.1), borderRadius: BorderRadius.circular(16.r)),
                    child: Column(
                      children: [
                        Icon(Icons.support_agent, size: 48, color: AppColors.active),
                        SizedBox(height: 12.fh),
                        Text('Не нашли ответ?', style: AppTypography.text2Semibold.copyWith(color: AppColors.dark)),
                        SizedBox(height: 8.fh),
                        Text(
                          'Наша поддержка готова помочь',
                          style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.fh),
                        SizedBox(
                          width: double.infinity,
                          height: 50.fh,
                          child: ElevatedButton(
                            onPressed: () {
                              showContactForm(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.active,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            ),
                            child: Text('Написать в поддержку', style: AppTypography.text2Semibold.copyWith(color: AppColors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.fh),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget faqItem(String question, String answer) {
    return Container(
      padding: EdgeInsets.all(16.fw),
      decoration: BoxDecoration(color: AppColors.light.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: AppColors.active, size: 20),
              SizedBox(width: 8.fw),
              Expanded(
                child: Text(
                  question,
                  style: AppTypography.text2Meduim.copyWith(color: AppColors.dark, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.fh),
          Text(answer, style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey, height: 1.5)),
        ],
      ),
    );
  }

  void showContactForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Написать в поддержку', style: AppTypography.text2Semibold),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Ваш вопрос',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                hintText: 'Опишите вашу проблему...',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена', style: AppTypography.textMeduim.copyWith(color: AppColors.light_grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Сообщение отправлено! Мы ответим в ближайшее время'), backgroundColor: AppColors.active));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.active),
            child: Text('Отправить', style: AppTypography.textMeduim.copyWith(color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}
