import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/providers/dashboard_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_image.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/extensions/string.dart';
import 'package:recipe/shared/widget/app_input.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';
import 'package:recipe/shared/widget/gradient_container.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  void initState() {
    Provider.of<DashboardProvider>(context, listen: false)
        .getAllRecipes(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    title: 'Explore',
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
                  const AppSpacing(v: 24),
                  Expanded(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 34,
                          child: AppInput(
                            controller: controller.searchController,
                            hintText: 'Search',
                            borderRadius: 8,
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 8,
                              ),
                              child: AppIcon(
                                icon: AppIconData.search,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        if (controller.isLoading)
                          const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else if (controller.searchedRecipeList.isNotEmpty)
                          Expanded(
                            child: GridView.builder(
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
                              itemCount: controller.searchedRecipeList.length,
                              itemBuilder: (context, index) {
                                final item =
                                    controller.searchedRecipeList[index];
                                return RecipeListCard(
                                  item: item,
                                  onTap: (item) {
                                    controller.viewRecipeDetails(item, context);
                                  },
                                );
                              },
                            ),
                          )
                        else
                          Expanded(
                            child: GridView.builder(
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
                              itemCount: controller.allRecipeList.length,
                              itemBuilder: (context, index) {
                                final item = controller.allRecipeList[index];
                                return RecipeListCard(
                                  item: item,
                                  onTap: (item) {
                                    controller.viewRecipeDetails(item, context);
                                  },
                                );
                              },
                            ),
                          ),
                        const AppSpacing(v: 16),
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
  }
}

class RecipeListCard extends StatelessWidget {
  const RecipeListCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  final Recipe item;
  final Function(Recipe item) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onTap(item),
      child: SizedBox(
        height: 136,
        child: Stack(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppImage(
                    height: 136,
                    // width: 91,
                    imageUrl: item.imageUrl ?? '',
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 206,
                    color: AppColors.primaryColor.withOpacity(0.4),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name.toTitleCase,
                            style: AppTextStyle.bold16.copyWith(
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (item.dateSuggested != null)
                            const AppSpacing(v: 4),
                          if (item.dateSuggested != null)
                            Text(
                              item.dateSuggested!.toString().formatDate,
                              textAlign: TextAlign.start,
                              // overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.bold16.copyWith(
                                fontSize: 10,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const AppSpacing(h: 6),
                    CircleAvatar(
                      radius: 16.5,
                      backgroundColor: AppColors.peachColor,
                      child: Text(
                        (item.creatorName?.substring(0, 1) ?? 'G'.toString())
                            .toUpperCase(),
                        style: AppTextStyle.bold16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
