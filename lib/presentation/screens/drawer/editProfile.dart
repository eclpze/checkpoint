import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/components/customTextField.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: ps(h: 20, v: 30),
            child: Row(
              children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: arrowLeft()),
                Spacer(),
                Text(
                  'Изменение профиля',
                  style: AppTypography.title2Bold.copyWith(color: AppColors.dark, fontWeight: FontWeight.w500, fontSize: 17.fh),
                ),
                Spacer(),
                SizedBox(width: 40.fw),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.fw),
              child: Column(
                children: [
                  SizedBox(height: 20.fh),
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
                  SizedBox(height: 40.fh),
                  SizedBox(
                    width: double.infinity,
                    height: 50.fh,
                    child: ElevatedButton(
                      onPressed: saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.active,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text('Сохранить', style: AppTypography.text2Semibold.copyWith(color: AppColors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Профиль сохранён'), backgroundColor: AppColors.active));
  }
}
