import 'package:checkpoint/data/courseData.dart';
import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/presentation/screens/course/courseDetail.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/components/coursesCard.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class AllCoursesScreen extends StatelessWidget {
  const AllCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allCourses = CourseData.getAllCourses();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: ps(h: 20, v: 30),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    navToMainScreen(context);
                  },
                  child: arrowLeft(),
                ),
                SizedBox(width: 20.fw),
                Text(
                  'Все курсы',
                  style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontSize: 20.fh),
                ),
              ],
            ),
          ),
          Padding(
            padding: ps(h: 20),
            child: Row(
              children: [Text('${allCourses.length} курсов', style: AppTypography.text2Meduim.copyWith(color: AppColors.light_grey))],
            ),
          ),
          SizedBox(height: 15.fh),
          Expanded(
            child: GridView.builder(
              padding: ps(h: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.9),
              itemCount: allCourses.length,
              itemBuilder: (context, index) {
                final course = allCourses[index];
                return CourseCard(
                  course: course,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course)));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
