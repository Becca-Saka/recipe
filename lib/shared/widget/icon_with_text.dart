import 'package:flutter/material.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcon(
          icon: icon,
          size: 14,
        ),
        const AppSpacing(h: 6),
        Text(
          text,
          style: AppTextStyle.medium10.copyWith(
            fontSize: 12,
            color: AppColors.subtitleColor,
          ),
        ),
      ],
    );
  }
}
