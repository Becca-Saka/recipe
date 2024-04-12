import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/recipe_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_hero.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/extensions/string.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';
import 'package:recipe/shared/widget/icon_with_text.dart';

class SuggestedRecipesView extends StatelessWidget {
  const SuggestedRecipesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(
                    title: 'Suggested recipes',
                  ),
                  const AppSpacing(v: 16),
                  Text(
                    'From the ingredients you shared, here are some recipe suggestions for you;',
                    style: AppTextStyle.medium14.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      itemCount: controller.recipeList.length,
                      itemBuilder: (context, index) {
                        final item = controller.recipeList[index];
                        return InkWell(
                          onTap: () {
                            controller.viewRecipeDetails(item, context);
                          },
                          child: Container(
                            height: 95,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                width: 0.5,
                                color: const Color(0xFF616161),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppHero(
                                  tag: 'hero $index',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      height: 95,
                                      width: 91,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name.toTitleCase,
                                          style: AppTextStyle.bold16,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            TextWithIcon(
                                              text: item.cookTime.toTitleCase,
                                              icon: AppIconData.timeCheck,
                                            ),
                                            const AppSpacing(h: 18),
                                            TextWithIcon(
                                              text:
                                                  '${item.ingredients.length} ingredients',
                                              icon: AppIconData.menuBurger,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const AppSpacing(v: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
