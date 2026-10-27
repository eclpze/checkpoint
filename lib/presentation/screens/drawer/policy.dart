import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

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
                const Spacer(),
                Text(
                  'Политика приложения',
                  style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontWeight: FontWeight.w500, fontSize: 17.fh),
                ),
                const Spacer(),
                SizedBox(width: 40.fw),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.fw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.fh),
                  policySection(
                    'Пользовательское соглашение',
                    'Регистрируясь на платформе, вы соглашаетесь с условиями использования сервиса. Вы обязуетесь предоставлять достоверную информацию и не использовать сервис в незаконных целях.',
                  ),
                  SizedBox(height: 24.fh),
                  policySection('Политика конфиденциальности', 'Мы собираем и обрабатываем ваши персональные данные только для улучшения качества сервиса. Ваши данные не передаются третьим лицам без вашего согласия.'),
                  SizedBox(height: 24.fh),
                  policySection('Правила использования', 'Запрещается размещать контент нарушающий авторские права, оскорбительный или незаконный материал. Администрация оставляет за собой право блокировать аккаунты нарушителей.'),
                  SizedBox(height: 24.fh),
                  policySection('Возврат средств', 'Возврат средств возможен в течение 14 дней с момента покупки курса, если вы не прошли более 10% материала.'),
                  SizedBox(height: 30.fh),
                  SizedBox(
                    width: double.infinity,
                    height: 50.fh,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('С условиями согласен'), backgroundColor: AppColors.active));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.active,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text('Я согласен', style: AppTypography.text2Semibold.copyWith(color: AppColors.white)),
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

  Widget policySection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.text2Semibold.copyWith(color: AppColors.dark)),
        SizedBox(height: 8.fh),
        Text(content, style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey, height: 1.5)),
      ],
    );
  }
}
