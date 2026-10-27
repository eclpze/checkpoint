import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

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
                  'Безопасность',
                  style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontWeight: FontWeight.w500, fontSize: 17.fh),
                ),
                Spacer(),
                SizedBox(width: 40.fw),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.fw),
              children: [
                SizedBox(height: 20.fh),
                securityItem(Icons.lock_outline, 'Сменить пароль', 'Последнее изменение: 3 месяца назад', () {
                  showChangePasswordDialog(context);
                }),
                SizedBox(height: 16.fh),
                securityItem(Icons.phone_android, 'Двухфакторная аутентификация', 'Повышает безопасность аккаунта', () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('2FA скоро будет доступна'), backgroundColor: AppColors.active));
                }),
                SizedBox(height: 16.fh),
                securityItem(Icons.devices, 'Активные устройства', '1 устройство вошли в аккаунт', () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Список устройств'), backgroundColor: AppColors.active));
                }),
                SizedBox(height: 16.fh),
                securityItem(Icons.logout, 'Выйти со всех устройств', 'Завершить все активные сессии', () {
                  showLogoutDialog(context);
                }, isDestructive: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget securityItem(IconData icon, String title, String subtitle, VoidCallback onTap, {bool isDestructive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.fw),
        decoration: BoxDecoration(color: AppColors.light.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.red : AppColors.dark, size: 24),
            SizedBox(width: 16.fw),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.text2Meduim.copyWith(color: isDestructive ? Colors.red : AppColors.dark)),
                  SizedBox(height: 4.fh),
                  Text(subtitle, style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.light_grey),
          ],
        ),
      ),
    );
  }

  void showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Сменить пароль', style: AppTypography.text2Semibold),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Текущий пароль',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.fh),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Новый пароль',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Пароль изменён'), backgroundColor: AppColors.active));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.active),
            child: Text('Сохранить', style: AppTypography.textMeduim.copyWith(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Выйти со всех устройств?', style: AppTypography.text2Semibold),
        content: Text('Это завершит все активные сессии кроме текущей'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена', style: AppTypography.textMeduim.copyWith(color: AppColors.light_grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Все сессии завершены'), backgroundColor: Colors.red));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Выйти', style: AppTypography.textMeduim.copyWith(color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}
