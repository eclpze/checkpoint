import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/presentation/screens/course/activeCourseCard.dart';
import 'package:checkpoint/presentation/screens/course/courseDetail.dart';
import 'package:checkpoint/presentation/screens/course/manager.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/coursesCard.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Course>> coursesFuture;

  @override
  void initState() {
    super.initState();
    coursesFuture = CourseManager().getCourses();
  }

  List<Course> get activeCourses {
    return coursesFuture is Future ? [] : (coursesFuture as List<Course>).where((c) => c.isActive).toList();
  }

  void refreshCourses() {
    setState(() {
      coursesFuture = CourseManager().getCourses();
    });
  }

  Future<void> navigateToCourse(Course course) async {
    if (!course.isActive) {
      course.isActive = true;
      course.progress ??= 0.0;
      await CourseManager().saveCourseProgress(course);
      setState(() {});
    }

    await Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course)));

    refreshCourses();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: coursesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Ошибка: ${snapshot.error}')));
        }

        final allCourses = snapshot.data!;
        final activeCourses = allCourses.where((c) => c.isActive).toList();

        return WillPopScope(
          onWillPop: () async {
            refreshCourses();
            return true;
          },
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              padding: ps(h: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.fh),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navToDrawer(context);
                        },
                        child: Container(
                          width: 30.fw,
                          height: 30.fh,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                          ),
                          child: SvgPicture.asset('assets/icons/drawer.svg'),
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Привет, $name!',
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontSize: 18.fh),
                          ),
                          SizedBox(height: 5.fh),
                          Text('Начни свои занятия сейчас!', style: AppTypography.textMeduim.copyWith(color: AppColors.light_grey)),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: po(t: 29, b: 16),
                    child: Text('Начатые курсы', style: AppTypography.text2Semibold),
                  ),
                  if (activeCourses.isEmpty)
                    Row(
                      children: [
                        Text('Вы ещё не начали ни одного курса', style: AppTypography.textMeduim.copyWith(color: AppColors.light_grey)),
                        Spacer(),
                      ],
                    )
                  else
                    SizedBox(
                      height: 176.fh,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: activeCourses.length,
                        separatorBuilder: (_, i) => SizedBox(width: 21.fw),
                        itemBuilder: (_, i) => ActiveCourseCard(course: activeCourses[i], onTap: () => navigateToCourse(activeCourses[i])),
                      ),
                    ),
                  SizedBox(height: 27.fh),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Курсы', style: AppTypography.text2Semibold),
                      TextButton(
                        onPressed: () {
                          navToAllCourses(context);
                        },
                        child: Text(
                          'Все',
                          style: AppTypography.textMeduim.copyWith(color: AppColors.active, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.fh),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.9),
                    itemCount: allCourses.length,
                    itemBuilder: (context, index) {
                      final course = allCourses[index];
                      return CourseCard(course: course, onTap: () => navigateToCourse(course));
                    },
                  ),
                  SizedBox(height: 20.fh),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
