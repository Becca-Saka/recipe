import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/providers/dashboard_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_hero.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_image.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/extensions/num.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DashboardProvider>(context, listen: false).getAllRecipes();
    });

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
                            sematicLabel: 'Home',
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
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else if (controller.searchedRecipeList.isNotEmpty)
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
                            itemCount: controller.searchedRecipeList.length,
                            itemBuilder: (context, index) {
                              final item = controller.searchedRecipeList[index];
                              return RecipeListCard(
                                item: item,
                                onTap: (item) {
                                  controller.viewRecipeDetails(item, context);
                                },
                              );
                            },
                          )
                        else
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
    this.showUser = true,
  });

  final Recipe item;
  final bool showUser;
  final Function(Recipe item) onTap;

  @override
  Widget build(BuildContext context) {
    return AppHero(
      tag: item.name,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap(item),
        child: SizedBox(
          height: 136,
          child: Stack(
            children: [
              Stack(
                children: [
                  AppImage(
                    radius: 12,
                    height: 136,
                    width: double.infinity,
                    imageUrl: item.imageUrl ?? '',
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
                        fit: FlexFit.tight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name.toTitleCase,
                              style: AppTextStyle.bold16.copyWith(fontSize: 14),
                            ),
                            if (item.dateSuggested != null)
                              const AppSpacing(v: 4),
                            if (item.dateSuggested != null)
                              Text(
                                item.dateSuggested!.toString().formatDate,
                                textAlign: TextAlign.start,
                                style:
                                    AppTextStyle.bold16.copyWith(fontSize: 10),
                              ),
                          ],
                        ),
                      ),
                      if (showUser && item.creators.isNotEmpty)
                        AvatarStack(creators: item.creators)
                      else
                        const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvatarStack extends StatelessWidget {
  final List<CreatorModel> creators;
  const AvatarStack({super.key, required this.creators});

  @override
  Widget build(BuildContext context) {
    final moreCreators = creators.length > 3;
    final list = moreCreators ? creators.take(3) : creators;
    return Semantics(
      label: '${creators.length} Creators',
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const AppSpacing(h: 16),
            ...list.map((e) => _avatar(
                  color: AppColors.peachColor,
                  name: e.name.substring(0, 1).toUpperCase(),
                  imageUrl: e.imageUrl,
                )),
            if (moreCreators)
              _avatar(
                color: AppColors.darkGrey,
                name: '+${(creators.length - 3).minify}',
              ),
          ],
        ),
      ),
    );
  }

  Widget _avatar({
    required Color color,
    required String name,
    String? imageUrl,
  }) {
    return Align(
      widthFactor: 0.3,
      alignment: Alignment.bottomCenter,
      child: CircleAvatar(
        radius: 16.5,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0.5),
          child: CircleAvatar(
            radius: 16.5,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
            backgroundColor: color,
            child: imageUrl != null
                ? null
                : Text(
                    name,
                    style: AppTextStyle.bold16.copyWith(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
