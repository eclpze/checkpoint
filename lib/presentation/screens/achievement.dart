import 'package:checkpoint/data/models/achievementModel.dart';
import 'package:checkpoint/domain/userWallet.dart';
import 'package:checkpoint/presentation/screens/course/manager.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';
import 'package:checkpoint/data/models/courseModel.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  late Future<List<Course>> _coursesFuture;
  final _achievementManager = AchievementManager();

  @override
  void initState() {
    super.initState();
    _coursesFuture = CourseManager().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: FutureBuilder<List<Course>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          final allCourses = snapshot.data ?? [];
          final completedCourses = allCourses.where((c) {
            final unlockable = c.lessons.where((l) => !l.isLocked).toList();
            return unlockable.isNotEmpty && unlockable.every((l) => l.isCompleted);
          }).length;
          final completedLessons = allCourses.fold(0, (sum, c) => sum + c.lessons.where((l) => l.isCompleted).length);
          final completedTests = allCourses.fold(0, (sum, c) => sum + c.lessons.where((l) => l.type == 'test' && l.isCompleted).length);
          final totalPoints = UserWallet().balance.value;
          final achievements = _achievementManager.getAchievements();

          return Column(
            children: [
              header(),
              statsRow(completedCourses, completedLessons, completedTests, totalPoints),
              sectionTitle('Ваши достижения', achievements, completedCourses, completedLessons, completedTests, totalPoints),
              Expanded(
                child: ListView.separated(
                  padding: ps(h: 20),
                  itemCount: achievements.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.fh),
                  itemBuilder: (context, index) {
                    final achievement = achievements[index];
                    final isUnlocked = _achievementManager.isUnlocked(achievement, completedCourses: completedCourses, completedLessons: completedLessons, completedTests: completedTests, totalPoints: totalPoints);
                    final progress = _achievementManager.getProgress(achievement, completedCourses: completedCourses, completedLessons: completedLessons, completedTests: completedTests, totalPoints: totalPoints);
                    final unlockDate = _achievementManager.getUnlockDate(achievement.id);
                    return achievementCard(achievement, isUnlocked, progress, unlockDate);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget sectionTitle(String title, List<Achievement> achievements, int completedCourses, int completedLessons, int completedTests, int totalPoints) {
    final unlockedCount = achievements.where((a) => _achievementManager.isUnlocked(a, completedCourses: completedCourses, completedLessons: completedLessons, completedTests: completedTests, totalPoints: totalPoints)).length;

    return Padding(
      padding: ps(h: 20, v: 10),
      child: Row(
        children: [
          Text(title, style: AppTypography.text2Semibold.copyWith(color: AppColors.dark)),
          const Spacer(),
          Text('$unlockedCount/${achievements.length}', style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey)),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: ps(h: 20, v: 30),
      child: Row(
        children: [
          const Spacer(),
          Text(
            'Достижения',
            style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontSize: 20.fh),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget statsRow(int completedCourses, int completedLessons, int completedTests, int totalPoints) {
    return Padding(
      padding: ps(h: 20),
      child: Row(
        children: [
          statItem(Icons.school, '$completedCourses', 'Курсов'),
          statItem(Icons.menu_book, '$completedLessons', 'Уроков'),
          statItem(Icons.check_circle_outline, '$completedTests', 'Тестов'),
          statItem(Icons.star, '$totalPoints', 'Баллов'),
        ].expand((widget) => [widget, SizedBox(width: 8.fw)]).toList()..removeLast(),
      ),
    );
  }

  Widget statItem(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.fh),
        decoration: BoxDecoration(color: AppColors.light.withOpacity(0.15), borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: [
            Icon(icon, size: 24, color: AppColors.dark.withOpacity(0.8)),
            SizedBox(height: 4.fh),
            Text(value, style: AppTypography.text2Semibold.copyWith(color: AppColors.dark)),
            Text(label, style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey)),
          ],
        ),
      ),
    );
  }

  Widget achievementCard(Achievement achievement, bool isUnlocked, int progress, DateTime? unlockDate) {
    return Container(
      padding: pa(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isUnlocked ? AppColors.active.withOpacity(0.3) : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          achievementIcon(achievement, isUnlocked: isUnlocked),
          SizedBox(width: 16.fw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(achievement.title, style: AppTypography.text2Semibold.copyWith(color: isUnlocked ? AppColors.dark : AppColors.light_grey)),
                    ),
                    if (isUnlocked)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.fw, vertical: 4.fh),
                        decoration: BoxDecoration(color: AppColors.active.withOpacity(0.15), borderRadius: BorderRadius.circular(8.r)),
                        child: Text(
                          'Получено',
                          style: AppTypography.text3Meduim.copyWith(color: AppColors.active, fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.fh),
                Text(achievement.description, style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey)),
                if (!isUnlocked && achievement.required != null) ...[
                  SizedBox(height: 12.fh),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6.fh,
                          decoration: BoxDecoration(color: AppColors.light, borderRadius: BorderRadius.circular(6.r)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: LinearProgressIndicator(
                              value: achievement.required! > 0 ? progress / achievement.required! : 0,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.active),
                              minHeight: 6.fh,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.fw),
                      Text('$progress/${achievement.required}', style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey)),
                    ],
                  ),
                ],
                if (isUnlocked && unlockDate != null) ...[SizedBox(height: 4.fh), Text('Получено ${formatDate(unlockDate)}', style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey.withOpacity(0.7)))],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget achievementIcon(Achievement achievement, {required bool isUnlocked}) {
    return Container(
      width: 56.fw,
      height: 56.fh,
      decoration: BoxDecoration(color: isUnlocked ? AppColors.active.withOpacity(0.15) : AppColors.light.withOpacity(0.3), shape: BoxShape.circle),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(achievement.iconPath, width: 32.fw, height: 32.fh, colorFilter: ColorFilter.mode(isUnlocked ? AppColors.active : AppColors.light_grey, BlendMode.srcIn)),
          if (!isUnlocked)
            Container(
              width: 56.fw,
              height: 56.fh,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.light_grey.withOpacity(0.3), width: 2, style: BorderStyle.solid),
              ),
              child: Center(child: Icon(Icons.lock, size: 20, color: AppColors.light_grey.withOpacity(0.5))),
            ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    const months = ['янв', 'фев', 'мар', 'апр', 'май', 'июн', 'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'];
    return '${date.day} ${months[date.month - 1]}';
  }
}
