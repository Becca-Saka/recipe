import 'package:flutter/material.dart';
import 'package:recipe/shared/app_colors.dart';

import 'circular_button.dart';
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
    return Stack(
      alignment: Alignment.center,
      children: [
        if (!isNotListening)
          ExpandingCircle(
            colors: [
              Colors.white,
              AppColors.secondaryColor.withOpacity(0.2),
              AppColors.tertiaryColor.withOpacity(0.5),
            ],
            size: 80,
          ),
        CircularButton(
          size: 50,
          backgroundColor:
              isNotListening ? AppColors.secondaryColor : Colors.red,
          onPressed: onPressed,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              isNotListening ? Icons.mic_off : Icons.stop,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
