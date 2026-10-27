import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    animateToOnboarding(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.active,
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/images/splash.png', width: 235.fw, height: 235.fh),
        ),
      ),
    );
  }
}
