import 'package:checkpoint/data/data.dart';
import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/customTabbar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: CustomTabBar(
        image: ['assets/icons/home.svg', 'assets/icons/graduation-cap.svg', 'assets/icons/resourses.svg', 'assets/icons/profile.svg'],
        selectedValue: selectedIndex,
        onPressed: onItemTapped,
        color: AppColors.white,
      ),
    );
  }
}
