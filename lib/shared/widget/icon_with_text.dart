import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    super.key,
    required this.text,
    required this.icon,
    this.textStyle,
  });

  final String text;
  final String icon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            size: 14,
          ),
          const AppSpacing(h: 6),
          Flexible(
            child: Text(
              text,
              style: textStyle ??
                  AppTextStyle.medium10.copyWith(
                    fontSize: 12,
                    color: AppColors.subtitleColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
