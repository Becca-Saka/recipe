import 'package:flutter/material.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_image.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.waterMarked = true,
    this.hasBackButton = true,
    this.waterMark,
    this.actions,
    this.titleTextSize,
  });
  final bool waterMarked;
  final bool hasBackButton;
  final String title;
  final double? titleTextSize;
  final Widget? waterMark;
  final Widget? actions;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (hasBackButton)
              AppIcon(
                icon: AppIconData.back,
                size: 24,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            const AppSpacing(h: 10),
            Text(
              title,
              style: AppTextStyle.bold16.copyWith(
                fontSize: titleTextSize,
              ),
            ),
            const Spacer(),
            if (actions != null) actions!,
            if (waterMarked)
              waterMark ??
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Powered by ',
                        style: AppTextStyle.medium10,
                      ),
                      const AppImage(
                        sematicsLabel: 'Gemini',
                        imageUrl: 'assets/images/gemini_logo.png',
                        height: 19,
                        width: 39,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
