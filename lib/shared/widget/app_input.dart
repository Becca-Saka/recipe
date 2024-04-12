import 'package:flutter/material.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_text_style.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 8,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: AppTextStyle.medium14.copyWith(
          color: AppColors.subtitleColor,
        ),
        fillColor: const Color(0xFF1E1F20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
