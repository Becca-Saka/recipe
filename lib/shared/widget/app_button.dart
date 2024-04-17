import 'package:flutter/material.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final bool isLoading;
  final Widget? suffix;
  final bool expanded;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.onPressed,
    this.title,
    this.isLoading = false,
    this.expanded = true,
    this.suffix,
    this.width,
    this.height,
    this.padding,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: color == null
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.32, 1.0],
                colors: [
                  Color(0xFFC46780),
                  Color(0xFF8D8FFB),
                  Color(0xFF338AD3),
                ],
              )
            : null,
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      height: height ?? 50,
      width: expanded ? double.infinity : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: Colors.transparent,
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
                  suffix ??
                      const AppIcon(
                        icon: AppIconData.redoSpark,
                        size: 18,
                      ),
                  if (title != null) const AppSpacing(h: 10),
                  if (title != null)
                    Text(
                      title!,
                      style: AppTextStyle.semibold14.copyWith(
                        color: textColor,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
