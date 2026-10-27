import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/customButton.dart';
import 'package:checkpoint/presentation/uikit/components/customTextField.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.white,
    body: Column(
      children: [
        SizedBox(height: 30.fh),
        Row(
          children: [
            Spacer(),
            Text(
              'Профиль',
              style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontSize: 20.fh),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 10.fh),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.fw),
            child: Column(
              children: [
                SizedBox(height: 30.fh),
                Stack(
                  children: [
                    Container(
                      width: 120.fw,
                      height: 120.fh,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.active),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 40.fw,
                        height: 40.fh,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                          boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.1), blurRadius: 4)],
                        ),
                        child: Icon(Icons.camera_alt, size: 20, color: AppColors.active),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.fh),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Имя',
                  keyboardType: TextInputType.text,
                  prefixIcon: Padding(padding: ps(h: 17.5, v: 15), child: SvgPicture.asset('assets/icons/user.svg')),
                ),
                SizedBox(height: 22.fh),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Почта',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Padding(padding: ps(h: 17.5, v: 15), child: SvgPicture.asset('assets/icons/message.svg')),
                ),
                SizedBox(height: 50.fh),
                CustomButton(onPressed: saveProfile, textButton: 'Сохранить', colorButton: AppColors.active),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  void saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Профиль сохранён'), backgroundColor: AppColors.active));
  }
}
