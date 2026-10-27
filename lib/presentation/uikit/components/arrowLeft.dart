import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

Widget arrowLeft() {
  return Container(
    width: 10.fw,
    height: 16.fh,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: SvgPicture.asset(
      'icons/arrow_left.svg',
      width: 7.fw,
      height: 14.fh,
    ),
  );
}