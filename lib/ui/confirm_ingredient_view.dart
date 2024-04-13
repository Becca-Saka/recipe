import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/recipe_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_image.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/extensions/string.dart';
import 'package:recipe/shared/widget/app_button.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';

class ConfirmIngredientView extends StatelessWidget {
  const ConfirmIngredientView({super.key});

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
                    title: 'Confirm Ingredients',
                  ),
                  const AppSpacing(v: 16),
                  Text(
                    'Confirm that these are the ingredients you listed;',
                    style: AppTextStyle.medium14.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      itemCount: controller.ingredientList.length,
                      itemBuilder: (context, index) {
                        final item = controller.ingredientList[index];

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AppImage(
                                height: 58,
                                width: 58,
                                imageUrl: item.imageUrl,
                              )),
                          title: Text(item.name.toTitleCase),
                          subtitle: Text(
                            item.quantity +
                                (item.quantity.isNotEmpty ? " " : '') +
                                item.unit,
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
                    onPressed: () => controller.getRecipes(context),
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
