import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: pa(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.18.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12.r),
                  image: course.imageUrl.isNotEmpty
                      ? DecorationImage(
                    image: AssetImage(course.imageUrl),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: course.imageUrl.isEmpty
                    ? Center(
                  child: Icon(
                    Icons.school,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                )
                    : null,
              ),
            ),
            SizedBox(height: 12.fh),
            Text(
              course.title,
              style: AppTypography.text3Meduim.copyWith(color: AppColors.dark),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.fh),
            Text(
              course.formattedSubtitle,
              style: AppTypography.text3Meduim.copyWith(
                color: AppColors.light_grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
