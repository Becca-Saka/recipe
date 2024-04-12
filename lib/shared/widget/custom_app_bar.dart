import 'package:flutter/material.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.waterMarked = true,
    required this.title,
  });
  final bool waterMarked;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              style: AppTextStyle.bold16,
            ),
            const Spacer(),
            if (waterMarked)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Powered by ',
                    style: AppTextStyle.medium10,
                  ),
                  Image.asset(
                    'assets/images/gemini_logo.png',
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
