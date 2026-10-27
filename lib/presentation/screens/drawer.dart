import 'package:checkpoint/data/data.dart';
import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/presentation/screens/drawer/aboutApp.dart';
import 'package:checkpoint/presentation/screens/drawer/editProfile.dart';
import 'package:checkpoint/presentation/screens/drawer/policy.dart';
import 'package:checkpoint/presentation/screens/drawer/security.dart';
import 'package:checkpoint/presentation/screens/drawer/support.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: ps(h: 14, v: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      navToMainScreen(context);
                    },
                    child: Container(
                      width: 40.fw,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                      ),
                      child: SvgPicture.asset('icons/arrow_left.svg', width: 40.fw, height: 40.fh),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Профиль',
                    textAlign: TextAlign.center,
                    style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontSize: 20.fh),
                  ),
                  Spacer(),
                  SizedBox(width: 40.fw, height: 40.fh),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 117.fw,
                    height: 117.fh,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.active),
                  ),
                  SizedBox(height: 11.fh),
                  Text('$name', style: AppTypography.text2Semibold),
                  SizedBox(height: 3.fh),
                  Text('$email', style: AppTypography.text3Bold),
                ],
              ),
            ),
            SizedBox(height: 31.fh),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onItemSelected(context, index),
                    child: Padding(
                      padding: ps(h: 43, v: 17),
                      child: Row(
                        children: [
                          SvgPicture.asset(icons[index], width: 24.fw, height: 24.fh, colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn)),
                          SizedBox(width: 25.fw),
                          Text(titles[index], style: AppTypography.textMeduim.copyWith(color: Colors.black)),
                          const Spacer(),
                          SvgPicture.asset('icons/arrow_right.svg', width: 9.86.fw, height: 17.25.fh, colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onItemSelected(BuildContext context, int index) {
    navToDrawer(context);

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfileScreen()));
        break;

      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SecurityScreen()));
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PolicyScreen()));
        break;

      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportScreen()));
        break;

      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutScreen()));
        break;

      default:
        break;
    }
  }
}
