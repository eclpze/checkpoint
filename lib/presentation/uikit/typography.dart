import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class AppTypography {
  static get title1Semibold => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 28.fh, color: AppColors.black);

  static get title2Semibold => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 24.fh, color: AppColors.black);

  static get title2Bold => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 24.fh, color: AppColors.black);

  static get text1Semibold => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 17.fh, color: AppColors.black);

  static get text2Bold => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 16.fh, color: AppColors.grey);

  static get text2Meduim => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 16.fh, color: AppColors.grey);

  static get text2Semibold => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 16.fh, color: AppColors.dark);

  static get textMeduim => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14.fh, color: AppColors.grey);

  static get text3Meduim => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 12.fh, color: AppColors.white);

  static get text3Bold => TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 11.fh, color: AppColors.grey);

}
