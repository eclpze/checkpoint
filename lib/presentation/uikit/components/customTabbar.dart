import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> image; // Пути к SVG иконкам
  final int selectedValue; // Текущий выбранный индекс
  final ValueChanged<int> onPressed; // Callback при нажатии
  final Color color; // Фон панели

  const CustomTabBar({
    super.key,
    required this.image,
    required this.selectedValue,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.fh,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          image.length,
              (index) => Expanded(
            child: GestureDetector(
              onTap: () => onPressed(index),
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: SvgPicture.asset(
                  image[index],
                  width: 20.fw,
                  height: 20.fh,
                  colorFilter: ColorFilter.mode(
                    selectedValue == index ? AppColors.active : AppColors.inactive_nav,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}