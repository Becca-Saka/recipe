import 'package:flutter/material.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';

class TransparentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String title;
  final Widget? prefix;
  final Widget? suffix;
  final double? width;
  final Color? color;
  const TransparentButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
    this.prefix,
    this.suffix,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: width ?? double.infinity,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              10,
            )),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefix != null) prefix!,
                    if (prefix != null) AppSpacing.h8(),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.medium14.copyWith(
                        fontSize: 16,
                        color: color,
                      ),
                    ),
                    if (suffix != null) const Spacer(),
                    if (suffix != null) suffix!,
                  ],
                ),
        ),
      ),
    );
  }
}
