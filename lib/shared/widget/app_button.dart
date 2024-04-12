import 'package:flutter/material.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isLoading;
  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.32, 1.0],
          colors: [
            Color(0xFFC46780),
            Color(0xFF8D8FFB),
            Color(0xFF338AD3),
          ],
        ),
        color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          // elevation: MaterialStateProperty.all(3),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppIcon(
                    icon: AppIconData.redoSpark,
                    size: 18,
                  ),
                  const AppSpacing(h: 10),
                  Text(
                    'Generate recipe',
                    style: AppTextStyle.semibold14,
                  ),
                ],
              ),
      ),
    );
  }
}
