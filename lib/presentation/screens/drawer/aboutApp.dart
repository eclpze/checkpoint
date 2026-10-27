import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                  'О приложении',
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
                children: [
                  SizedBox(height: 30.fh),
                  Container(
                    width: 100.fw,
                    height: 100.fh,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.active),
                    child: Icon(Icons.school, size: 50, color: AppColors.white),
                  ),
                  SizedBox(height: 16.fh),
                  Text(
                    'Checkpoint',
                    style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontSize: 24.fh),
                  ),
                  SizedBox(height: 8.fh),
                  Text('Версия 1.0.0', style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey)),
                  SizedBox(height: 40.fh),
                  infoItem(Icons.info_outline, 'О платформе', 'Checkpoint — это образовательная платформа для изучения современных технологий и инструментов разработки.'),
                  SizedBox(height: 16.fh),
                  infoItem(Icons.code, 'Технологии', 'Приложение разработано на Flutter с использованием современных практик и паттернов.'),
                  SizedBox(height: 16.fh),
                  infoItem(Icons.shield_outlined, 'Лицензия', '© 2024 Checkpoint. Все права защищены.\nИспользование без разрешения запрещено.'),
                  SizedBox(height: 16.fh),
                  infoItem(Icons.email_outlined, 'Контакты', 'Email: support@checkpoint.com\nТелефон: +7 (999) 123-45-67'),
                  SizedBox(height: 30.fh),
                  SizedBox(
                    width: double.infinity,
                    height: 50.fh,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('У вас последняя версия'), backgroundColor: AppColors.active));
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.active, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text('Проверить обновления', style: AppTypography.text2Semibold.copyWith(color: AppColors.active)),
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

  Widget infoItem(IconData icon, String title, String content) {
    return Container(
      padding: EdgeInsets.all(16.fw),
      decoration: BoxDecoration(color: AppColors.light.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.active, size: 24),
          SizedBox(width: 12.fw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.text2Meduim.copyWith(color: AppColors.dark, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.fh),
                Text(content, style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
