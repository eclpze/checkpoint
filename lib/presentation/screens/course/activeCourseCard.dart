import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class ActiveCourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const ActiveCourseCard({super.key, required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final progress = course.progress ?? 0.0;
    final completedLessons = (progress * course.totalLessons).round();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 157.fw,
        padding: pa(16),
        decoration: BoxDecoration(
          color: course.isActive ? AppColors.active : Colors.white,
          borderRadius: BorderRadius.circular(14.28.r),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 130.fw,
              child: Text(
                course.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: AppTypography.text2Semibold.copyWith(color: course.isActive ? AppColors.white : AppColors.dark),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 6.fh,
                  decoration: BoxDecoration(color: course.isActive ? AppColors.white.withOpacity(0.3) : AppColors.light, borderRadius: BorderRadius.circular(6.r)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: LinearProgressIndicator(value: progress, backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation<Color>(AppColors.light), minHeight: 6.fh),
                  ),
                ),
                SizedBox(height: 8.fh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${(progress * 100).toInt()}%', style: AppTypography.text3Meduim.copyWith(color: course.isActive ? AppColors.white : AppColors.dark)),
                    Text('$completedLessons of ${course.totalLessons}', style: AppTypography.text3Meduim.copyWith(color: course.isActive ? AppColors.white.withOpacity(0.9) : AppColors.dark)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
