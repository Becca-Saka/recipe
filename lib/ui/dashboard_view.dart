import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/dashboard_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/widget/gradient_container.dart';
import 'package:recipe/ui/collect_ingredient_view.dart';
import 'package:recipe/ui/explore_view.dart';
import 'package:recipe/ui/home_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final screens = const [
    ExploreView(),
    Center(child: Text('Settings')),
    HomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, controller, child) {
      return Scaffold(
        body: screens[controller.selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                horizontal: 38,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: AppIconData.discovery,
                    size: 30,
                    onTap: () => controller.onItemTapped(0),
                  ),
                  AppIcon(
                    icon: AppIconData.settings,
                    size: 30,
                    onTap: () => controller.onItemTapped(1),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
