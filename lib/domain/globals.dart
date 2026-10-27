import 'dart:io';
import 'package:checkpoint/domain/prefs.dart';
import 'package:checkpoint/presentation/screens/course/allCourses.dart';
import 'package:checkpoint/presentation/screens/drawer.dart';
import 'package:checkpoint/presentation/screens/mainScreen.dart';
import 'package:checkpoint/presentation/screens/onboarding.dart';
import 'package:checkpoint/presentation/screens/auth/registration.dart';
import 'package:checkpoint/presentation/screens/auth/signIn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final PageController pageController = PageController();

final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
final regKey = GlobalKey<FormState>();
final signKey = GlobalKey<FormState>();
int currentPage = 0;
int selectedIndex = 0;
bool isPasswordVisible = false;
bool isAgreementChecked = false;

String name = Prefs.getRegisteredName() ?? 'Пользователь';
String email = Prefs.getRegisteredEmail() ?? 'Почта';
String password = Prefs.getRegisteredPassword() ?? '';

bool get hasSign => emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

bool get hasReg => nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

void onItemSelected(BuildContext context, int index) {
  switch (index) {
    case 0:
      // Изменение профиля
      break;
    case 1:
      // Безопасность
      break;
    case 2:
      // Политика приложения
      break;
    case 3:
      // Поддержка
      break;
    case 4:
      // О приложении
      break;
  }
}

void clearControllers() {
  nameController.clear();
  emailController.clear();
  passwordController.clear();
}

void animateToOnboarding(BuildContext context) {
  Future.delayed(Duration(seconds: 2), () {
    navToOnboarding(context);
  });
}

void navToOnboarding(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Onboarding()));
}

void navToMainScreen(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
}

void navToReg(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Registration()));
  clearControllers();
}

void navToOnSign(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
  clearControllers();
}

void navToDrawer(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DrawerScreen()));
}

void navToAllCourses(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AllCoursesScreen()));
}

String? avatarPath;

Future<void> saveAvatar(String path) async {
  print('💾 Saving avatar path: $path');
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar_path', path);
    avatarPath = path;
    print('✅ Avatar saved to prefs');
  } catch (e) {
    print('❌ Error saving avatar: $e');
  }
}

Future<void> loadAvatar() async {
  print('📥 Loading avatar from prefs...');
  try {
    final prefs = await SharedPreferences.getInstance();
    avatarPath = prefs.getString('avatar_path');
    if (avatarPath != null) {
      print('✅ Avatar loaded: $avatarPath');

      // Проверяем, существует ли файл
      final file = File(avatarPath!);
      if (await file.exists()) {
        print('✅ Avatar file exists');
      } else {
        print('⚠️ Avatar file does not exist at path: $avatarPath');
        avatarPath = null; // Сбрасываем, если файл не найден
      }
    } else {
      print('⚠️ No avatar saved');
    }
  } catch (e) {
    print('❌ Error loading avatar: $e');
  }
}
