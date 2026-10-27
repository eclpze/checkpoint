import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  final Color colorButton;
  final double? width;
  final double? height;

  const CustomButton({super.key, required this.onPressed, required this.textButton, required this.colorButton,  this.width,  this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 310.fw,
      height: height ?? 55.fh,
      child: ElevatedButton(
        onPressed: onPressed,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: colorButton,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
              elevation: 0,
              padding: EdgeInsets.zero,
              minimumSize: const Size(310, 55),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.transparent;
                }
                return Colors.transparent;
              }),
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                return colorButton;
              }),
            ),
        child: Center(
          child: Text(
            textButton,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
