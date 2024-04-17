import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/dashboard_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/widget/gradient_container.dart';
import 'package:recipe/ui/collect_ingredient_view.dart';
import 'package:recipe/ui/explore_view.dart';
import 'package:recipe/ui/home_view.dart';
import 'package:recipe/ui/settings_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  final screens = const [
    ExploreView(),
    SettingsView(),
    HomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex,
            children: screens,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CollectIngredientView(),
                ),
              );
            },
            child: const GradientContainer(
              height: 70,
              width: 70,
              shape: BoxShape.circle,
              child: Center(
                child: AppIcon(
                  icon: AppIconData.redoSpark,
                  size: 24,
                ),
              ),
            ),
          ),
          bottomNavigationBar: ColoredBox(
            // height: 50,
            color: AppColors.primaryColor.withOpacity(0.9),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: Container(
                // height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  // vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getAppIcons(
                      index: 0,
                      currentIndex: controller.selectedIndex,
                      icon: AppIconData.discovery,
                      onTap: (index) => controller.onItemTapped(index),
                    ),
                    _getAppIcons(
                      index: 1,
                      currentIndex: controller.selectedIndex,
                      icon: AppIconData.settings,
                      onTap: (index) => controller.onItemTapped(index),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getAppIcons({
    required int index,
    required int currentIndex,
    required String icon,
    void Function(int)? onTap,
  }) {
    final active = index == currentIndex;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 4,
          width: 60,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
            color: active ? AppColors.peachColor : Colors.transparent,
          ),
        ),
        AppSpacing.v16(),
        AppIcon(
          icon: icon,
          size: 30,
          color: active ? AppColors.peachColor : Colors.white,
          onTap: () => onTap?.call(index),
        ),
      ],
    );
  }
}
