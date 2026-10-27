import 'package:checkpoint/data/data.dart';
import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < imageOnboardList.length - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      navToReg(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: imageOnboardList.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: po(t: 32, r: 30),
                        child: Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                navToReg(context);
                              },
                              child: Text('Пропустить', style: AppTypography.text1Semibold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 84.fh),
                      Container(
                        width: 313.fw,
                        height: 313.fh,
                        decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: AppColors.black.withOpacity(0.05),
                          //     blurRadius: 10,
                          //     offset: Offset(0, 5),
                          //   ),
                          // ],
                        ),
                        child: Image.asset(imageOnboardList[index]),
                      ),
                      SizedBox(height: 24.fh),
                      Padding(
                        padding: ps(h: 30),
                        child: Text(
                          titleOnboardList[index],
                          textAlign: TextAlign.center,
                          style: AppTypography.title2Semibold.copyWith(color: AppColors.dark),
                        ),
                      ),
                      SizedBox(height: 8.fh),
                      Padding(
                        padding: ps(h: 30),
                        child: Text(textOnboardList[index], textAlign: TextAlign.center, style: AppTypography.text2Meduim),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: ps(v: 29, h: 30),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: imageOnboardList.length,
                    effect: WormEffect(dotHeight: 12.fh, dotWidth: 12.fw, activeDotColor: AppColors.active, dotColor: AppColors.light_blue),
                  ),
                  const Spacer(),
                  (currentPage != 2)
                      ? GestureDetector(
                          onTap: nextPage,
                          child: Container(
                            width: 50.fw,
                            height: 50.fh,
                            decoration: BoxDecoration(color: AppColors.active, shape: BoxShape.circle),
                            child: Center(
                              child: SvgPicture.asset('assets/icons/arrow.svg', width: 20.fw, height: 20.fh),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            navToReg(context);
                          },
                          child: Container(
                            width: 130.fw,
                            height: 50.fh,
                            decoration: BoxDecoration(color: AppColors.active, borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: po(r: 9, l: 15),
                              child: Row(
                                children: [
                                  Text('Далее', style: AppTypography.text1Semibold.copyWith(color: AppColors.white)),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                                    width: 40.fw,
                                    height: 40.fh,
                                    child: Center(
                                      child: SvgPicture.asset('assets/icons/arrow.svg', width: 18.fw, height: 18.fh, color: AppColors.active),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
