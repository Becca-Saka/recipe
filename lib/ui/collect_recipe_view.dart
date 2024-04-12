import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/recipe_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/widget/app_button.dart';
import 'package:recipe/shared/widget/app_input.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';

class CollectRecipeView extends StatefulWidget {
  const CollectRecipeView({super.key});

  @override
  State<CollectRecipeView> createState() => _CollectRecipeViewState();
}

class _CollectRecipeViewState extends State<CollectRecipeView> {
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
                  if (controller.ingredientList.isNotEmpty)
                    Container(
                      height: 200,
                      color: Colors.grey[800],
                      child: ListView.builder(
                          itemCount: controller.ingredientList.length,
                          itemBuilder: (context, index) {
                            final item = controller.ingredientList[index];
                            return ListTile(
                              leading: const CircleAvatar(),
                              title: Text(item.name),
                              subtitle: Text('${item.quantity} ${item.unit}'),
                            );
                          }),
                    ),
                ],
              ),
            ),
          ));
    });
  }
}
