import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/user_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/widget/app_button.dart';
import 'package:recipe/shared/widget/app_transparent_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    final isSmall = height < 700 && width < 400;
    return Consumer<UserProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/background.png',
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Let’s Explore the World of Cooking',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bold16.copyWith(
                    fontSize: isSmall ? 36 : 40,
                  ),
                ),
                AppSpacing.v16(),
                Text(
                  'Sign in or Sign up to get a personalized experience on Recipé',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.medium14.copyWith(
                    fontSize: 16,
                  ),
                ),
                AppSpacing.v32(),
                AppButton(
                  onPressed: controller.logInWithGoogleUser,
                  height: 56,
                  color: Colors.white,
                  isLoading: controller.isGoogleLoading,
                  textColor: AppColors.primaryColor,
                  title: 'Continue with Google',
                  suffix: const AppIcon(
                    icon: AppIconData.google,
                    size: 24,
                  ),
                ),
                const AppSpacing(v: 22),
                TransparentButton(
                  title: 'Continue as a guest',
                  onPressed: () => controller.logInSilently(context),
                  isLoading: controller.isLoading,
                ),
                const AppSpacing(v: 24)
              ],
            ),
          ),
        );
      },
    );
  }
}
