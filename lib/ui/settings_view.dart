import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/dashboard_provider.dart';
import 'package:recipe/data/providers/user_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/widget/app_transparent_button.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';
import 'package:recipe/shared/widget/gradient_container.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomAppBar(
                    title: 'Settings',
                    titleTextSize: 24,
                    hasBackButton: false,
                    waterMarked: false,
                    actions: InkWell(
                      onTap: () {
                        Provider.of<DashboardProvider>(context, listen: false)
                            .onItemTapped(2);
                      },
                      child: const GradientContainer(
                        height: 35,
                        width: 35,
                        radius: 10,
                        child: Center(
                          child: AppIcon(
                            icon: AppIconData.home,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const AppSpacing(v: 31),
                  ListTile(
                    horizontalTitleGap: 0,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Promotion notifications',
                      style: AppTextStyle.semibold14,
                    ),
                    subtitle: Text(
                      'If turned on, you get notified on new offers and promotions available on Recipé.',
                      style: AppTextStyle.medium10.copyWith(
                        color: AppColors.subtitleColor,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Switch.adaptive(
                      value: controller.currentUser?.promotions ?? false,
                      onChanged: controller.updatePromotions,
                    ),
                  ),
                  const Divider(height: 32),
                  ListTile(
                    horizontalTitleGap: 6,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: const AppIcon(
                      icon: AppIconData.google,
                      size: 24,
                    ),
                    title: Text(
                      'Google',
                      style: AppTextStyle.medium14,
                    ),
                    trailing: controller.currentUser?.email == null
                        ? TransparentButton(
                            title: 'Connect',
                            onPressed: controller.connectGoogle,
                            width: 100,
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                controller.currentUser?.email ?? '',
                                style: AppTextStyle.medium10.copyWith(
                                  color: AppColors.subtitleColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Connected',
                                style: AppTextStyle.medium10.copyWith(
                                  color: const Color(0xFF4CAF50),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const Divider(height: 32),
                  const AppSpacing(v: 24),
                  TransparentButton(
                    title: 'Logout',
                    color: const Color(0xFFED4B9E),
                    onPressed: () => controller.logOut(context),
                    prefix: const AppIcon(
                      icon: AppIconData.out,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
