import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/dashboard_provider.dart';
import 'package:recipe/data/providers/recipe_provider.dart';
import 'package:recipe/data/providers/user_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_image.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/widget/app_transparent_button.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';
import 'package:recipe/shared/widget/gradient_background.dart';
import 'package:recipe/shared/widget/gradient_container.dart';
import 'package:recipe/shared/widget/icon_with_text.dart';
import 'package:recipe/ui/collect_ingredient_view.dart';
import 'package:recipe/ui/explore_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Provider.of<DashboardProvider>(context, listen: false).getUserRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    final isSmall = height < 700 && width < 400;
    return Consumer<UserProvider>(builder: (context, userController, child) {
      return Consumer<DashboardProvider>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    CustomAppBar(
                      title: 'Recipé',
                      titleTextSize: 24,
                      hasBackButton: false,
                      waterMarked: false,
                      actions: AppImage(
                        sematicsLabel: 'Profile Picture',
                        imageUrl: userController.currentUser?.imageUrl ??
                            AppIconData.user,
                        radius: 15,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const AppSpacing(v: 16),
                    Expanded(
                      child: ListView(
                        children: [
                          _GreetingCard(
                            width: width,
                            isSmall: isSmall,
                            name: userController.currentUser?.name,
                            recipeLength: controller.sugestedRecipeList.length,
                          ),
                          const AppSpacing(v: 16),
                          TransparentButton(
                            title: 'Generate a new recipe',
                            onPressed: () {
                              Provider.of<RecipeProvider>(context,
                                      listen: false)
                                  .textEditingController
                                  .clear();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CollectIngredientView(),
                                ),
                              );
                            },
                            suffix: const AppIcon(
                              excludeSemantics: true,
                              icon: AppIconData.forward,
                              size: 24,
                            ),
                            prefix: const GradientContainer(
                              height: 29,
                              width: 29,
                              shape: BoxShape.circle,
                              child: Center(
                                child: AppIcon(
                                  excludeSemantics: true,
                                  icon: AppIconData.redoSpark,
                                  size: 10,
                                ),
                              ),
                            ),
                          ),
                          const Divider(height: 42),
                          TextWithIcon(
                            text: 'Saved recipes',
                            icon: AppIconData.timePast,
                            textStyle: AppTextStyle.medium14,
                          ),
                          if (controller.isLoading)
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                          else if (controller.sugestedRecipeList.isNotEmpty)
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                mainAxisExtent: 136,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              itemCount: controller.sugestedRecipeList.length,
                              itemBuilder: (context, index) {
                                final item =
                                    controller.sugestedRecipeList[index];

                                final userProvider = Provider.of<UserProvider>(
                                    context,
                                    listen: false);
                                final recipes =
                                    userProvider.currentUser!.recipes;
                                item.dateSuggested = recipes
                                    .firstWhereOrNull(
                                        (element) => element.id == item.id)
                                    ?.dateSuggested;
                                return RecipeListCard(
                                  item: item,
                                  showUser: false,
                                  onTap: (item) {
                                    controller.viewRecipeDetails(item, context);
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class _GreetingCard extends StatelessWidget {
  const _GreetingCard({
    required this.width,
    required this.isSmall,
    required this.name,
    required this.recipeLength,
  });

  final double width;
  final bool isSmall;
  final String? name;
  final int recipeLength;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GradientBackground(
          height: 110,
          clipRadius: 15,
          mask: false,
          colors: [
            const GradientData(
              color: Color(0xFFCF5EEE),
              offset: Offset(65, -35),

              radius: 68,
              // offset: Offset(60, -height / 8),
            ),
            GradientData(
              color: const Color(0xFF8F90F2),
              offset: Offset(width / 1.3, 65),
              radius: 68,
            ),
            const GradientData(
              color: Color(0xFF72B8F4),
              offset: Offset(114, 170),
              radius: 88,
            ),

            // drawCircle(canvas, size, paint, offset, color);
          ],
          backgroundColor: AppColors.primaryColor,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hey ${name ?? 'Guest'},',
                      style: AppTextStyle.medium14
                          .copyWith(color: const Color(0xFFFFBDC1)),
                    ),
                    AppSpacing.v8(),
                    Text(
                      'What’s cooking?',
                      style: AppTextStyle.bold16.copyWith(
                        fontSize: isSmall ? 18 : 24,
                      ),
                    ),
                    AppSpacing.v16(),
                    TextWithIcon(
                      text: '$recipeLength recipe(s) generated',
                      icon: AppIconData.timePast,
                      textStyle: AppTextStyle.medium10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          right: 0,
          top: -22,
          child: AppImage(
            excludeSematics: true,
            imageUrl: 'assets/images/boy-cook.png',
            width: 131,
            height: 128,
          ),
        ),
      ],
    );
  }
}
