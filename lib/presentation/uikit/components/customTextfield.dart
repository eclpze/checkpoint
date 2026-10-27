import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextField({super.key, required this.controller, this.obscureText, required this.keyboardType, required this.hintText, this.suffixIcon, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5), spreadRadius: 0)],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        cursorColor: AppColors.active,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14.fh, color: AppColors.grey),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.grey.withOpacity(0.1), width: 2),
          ),
          contentPadding: ps(h: 16, v: 16),
        ),
      ),
    );
  }
}
