import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/recipe_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/widget/app_button.dart';
import 'package:recipe/shared/widget/app_input.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';

class CollectIngredientView extends StatefulWidget {
  const CollectIngredientView({super.key});

  @override
  State<CollectIngredientView> createState() => _CollectIngredientViewState();
}

class _CollectIngredientViewState extends State<CollectIngredientView> {
  @override
  void initState() {
    super.initState();
    Provider.of<RecipeProvider>(context, listen: false).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(builder: (context, controller, child) {
      return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const CustomAppBar(
                    title: 'Generate a new recipe',
                  ),
                  const AppSpacing(v: 30),
                  AppInput(
                    controller: controller.textEditingController,
                    hintText:
                        'Enter all the ingredients and quantity you currently have...',
                  ),
                  const AppSpacing(v: 20),
                  AppButton(
                    title: 'Generate recipe',
                    isLoading: controller.loading,
                    onPressed: () {
                      if (controller.textEditingController.text.isNotEmpty) {
                        controller.sendMessage(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ));
    });
  }
}