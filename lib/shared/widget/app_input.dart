import 'package:flutter/material.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_text_style.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.prefixIcon,
    this.contentPadding,
    this.borderRadius = 15.0,
  });
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final Widget? prefixIcon;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding,
        hintStyle: AppTextStyle.medium14.copyWith(
          color: AppColors.subtitleColor,
        ),
        fillColor: AppColors.darkGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
