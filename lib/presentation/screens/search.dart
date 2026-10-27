import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/presentation/screens/course/courseDetail.dart';
import 'package:checkpoint/presentation/screens/course/manager.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/coursesCard.dart';
import 'package:checkpoint/presentation/uikit/components/customButton.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Course>> _coursesFuture;
  List<Course> filteredCourses = [];
  String searchQuery = '';
  String selectedFilter = 'all';
  String selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _coursesFuture = CourseManager().getCourses();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _coursesFuture = CourseManager().getCourses();
    });
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: AppColors.light_grey),
                  SizedBox(height: 16.fh),
                  Text('Ошибка загрузки', style: AppTypography.text2Semibold.copyWith(color: AppColors.dark)),
                ],
              ),
            );
          }

          final allCourses = snapshot.data ?? [];
          final filteredCourses = applyFilters(allCourses);

          return Column(
            children: [
              header(),
              searchField(),
              Padding(padding: ps(v: 20), child: filters()),
              Expanded(child: filteredCourses.isEmpty ? emptyState() : coursesGrid(filteredCourses)),
            ],
          );
        },
      ),
    );
  }

  List<Course> applyFilters(List<Course> courses) {
    return courses.where((course) {
      final progress = course.progress ?? 0.0;
      final matchesSearch = course.title.toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesFilter = true;
      if (selectedFilter == 'active') {
        matchesFilter = progress > 0.01 && progress < 0.99;
      } else if (selectedFilter == 'completed') {
        matchesFilter = progress >= 0.99;
      } else if (selectedFilter == 'not_started') {
        matchesFilter = progress <= 0.01;
      }

      bool matchesCategory = true;
      if (selectedCategory != 'all') {
        matchesCategory = course.subtitle.toLowerCase().contains(selectedCategory.toLowerCase());
      }

      return matchesSearch && matchesFilter && matchesCategory;
    }).toList();
  }

  Widget header() {
    return Padding(
      padding: ps(h: 20, v: 30),
      child: Row(
        children: [
          const Spacer(),
          Text(
            'Все курсы',
            style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontSize: 20.fh),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: ps(h: 20),
      child: Container(
        height: 48.fh,
        decoration: BoxDecoration(color: AppColors.light.withOpacity(0.2), borderRadius: BorderRadius.circular(25.r)),
        child: TextField(
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
          cursorColor: AppColors.active,
          decoration: InputDecoration(
            hintText: 'Поиск курсов',
            hintStyle: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey),
            prefixIcon: Padding(
              padding: ps(v: 10, h: 15),
              child: SvgPicture.asset('icons/search.svg', color: AppColors.light_grey),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.fw, vertical: 12.fh),
          ),
        ),
      ),
    );
  }

  Widget filters() {
    return SizedBox(
      height: 40.fh,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: ps(h: 20),
        children: [
          filterChip('Все', 'all'),
          SizedBox(width: 10.fw),
          filterChip('Активные', 'active'),
          SizedBox(width: 10.fw),
          filterChip('Завершённые', 'completed'),
          SizedBox(width: 10.fw),
          filterChip('Не начаты', 'not_started'),
        ],
      ),
    );
  }

  Widget filterChip(String label, String value) {
    final isSelected = selectedFilter == value;
    return GestureDetector(
      onTap: () {
        selectedFilter = value;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.fw, vertical: 8.fh),
        decoration: BoxDecoration(color: isSelected ? AppColors.active : AppColors.light.withOpacity(0.5), borderRadius: BorderRadius.circular(30.r)),
        child: Center(
          child: Text(
            label,
            style: AppTypography.text3Meduim.copyWith(color: isSelected ? AppColors.white : AppColors.dark, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Future<void> navigateToCourse(Course course) async {
    if (!course.isActive) {
      course.isActive = true;
      course.progress ??= 0.0;
      await CourseManager().saveCourseProgress(course);
    }

    await Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course)));

    setState(() {
      _coursesFuture = CourseManager().getCourses();
    });
  }

  Widget coursesGrid(List<Course> courses) {
    return GridView.builder(
      padding: ps(h: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.9),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return CourseCard(course: course, onTap: () => navigateToCourse(course));
      },
    );
  }

  Widget emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 60.fw, color: AppColors.light_grey.withOpacity(0.5)),
          Text('Курсы не найдены', style: AppTypography.text2Meduim.copyWith(color: AppColors.dark)),
          SizedBox(height: 8.fh),
          Text(
            'Попробуйте изменить параметры поиска',
            style: AppTypography.text3Meduim.copyWith(color: AppColors.light_grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.fh),
          CustomButton(
            width: 185.fw,
            height: 40.fh,
            colorButton: AppColors.active,
            onPressed: () {
              setState(() {
                searchQuery = '';
                selectedFilter = 'all';
                selectedCategory = 'all';
              });
            },
            textButton: 'Сбросить фильтры',
          ),
        ],
      ),
    );
  }
}
