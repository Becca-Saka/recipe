import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/recipe_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/extensions/string.dart';
import 'package:recipe/shared/widget/app_button.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';

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
                        return Container(
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  height: 95,
                                  width: 91,
                                  color: Colors.brown,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.name.toTitleCase(),
                                        style: AppTextStyle.bold16,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          TextWithIcon(
                                            text: item.cookTime.toTitleCase(),
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
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  AppSpacing.v24(),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      //TODO: onadd
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 58,
                            width: 58,
                            color: const Color(0xFF323234),
                            child: const Icon(
                              Icons.add,
                              size: 24,
                            ),
                          ),
                        ),
                        const AppSpacing(h: 18),
                        Text(
                          'Add',
                          style: AppTextStyle.bold16,
                        ),
                      ],
                    ),
                  ),
                  const AppSpacing(v: 60),
                  AppButton(
                    title: 'Generate recipe',
                    isLoading: controller.loading,
                    onPressed: () {
                      //TODO:
                    },
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

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcon(
          icon: icon,
          size: 14,
        ),
        const AppSpacing(h: 6),
        Text(
          text,
          style: AppTextStyle.medium10.copyWith(
            fontSize: 12,
            color: AppColors.subtitleColor,
          ),
        ),
      ],
    );
  }
}
