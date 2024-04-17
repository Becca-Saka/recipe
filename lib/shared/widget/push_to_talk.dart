import 'package:flutter/material.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/widget/app_button.dart';

import 'expanding_circle.dart';

class PushToTalk extends StatelessWidget {
  final bool isNotListening;
  final void Function()? onPressed;
  const PushToTalk({
    super.key,
    required this.onPressed,
    required this.isNotListening,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!isNotListening)
            ExpandingCircle(
              colors: [
                AppColors.peachColor.withOpacity(0.3),
                AppColors.primaryColor,
                AppColors.peachColor.withOpacity(0.6),
                AppColors.blue.withOpacity(0.3),
                // Colors.white,
                // AppColors.secondaryColor.withOpacity(0.2),
                // AppColors.tertiaryColor.withOpacity(0.5),
              ],
              size: 60,
            ),
          AppButton(
            height: 40,
            width: 40,
            padding: EdgeInsets.zero,
            expanded: false,
            color: isNotListening ? AppColors.peachColor : Colors.white,
            onPressed: onPressed,
            suffix: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: AppIcon(
                icon: isNotListening ? AppIconData.voice : AppIconData.voice,
                size: 18,
                color: isNotListening ? Colors.white : AppColors.peachColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
