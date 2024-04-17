import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/recipe_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_hero.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_image.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/extensions/string.dart';
import 'package:recipe/shared/widget/app_button.dart';
import 'package:recipe/shared/widget/icon_with_text.dart';

class RecipeDetailsView extends StatefulWidget {
  const RecipeDetailsView({super.key});

  @override
  State<RecipeDetailsView> createState() => _RecipeDetailsViewState();
}

class _RecipeDetailsViewState extends State<RecipeDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(builder: (_, controller, child) {
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Builder(builder: (context) {
          final recipe = controller.selectedRecipe!;
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 300,
                  floating: false,
                  pinned: true,
                  snap: false,
                  // collapsedHeight: 300,
                  backgroundColor: Colors.white,
                  leadingWidth: 0,
                  automaticallyImplyLeading: false,
                  toolbarHeight: kToolbarHeight,
                  flexibleSpace: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    final top = constraints.biggest.height;
                    // const collapsed = false;
                    final collapsed = top ==
                        MediaQuery.of(context).padding.top + kToolbarHeight;

                    return Stack(
                      children: [
                        FlexibleSpaceBar(
                          title: collapsed
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BackButton(
                                      hasBackground: !collapsed,
                                    ),
                                    const Spacer(),
                                    Text(
                                      recipe.name,
                                      style: AppTextStyle.bold16.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                )
                              : null,
                          background: Stack(
                            children: [
                              Positioned.fill(
                                child: AppHero(
                                  tag: recipe.name,
                                  child: const AppImage(
                                    imageUrl: '',
                                    width: 142,
                                    height: 212,
                                    radius: 0,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: SizedBox(
                                    height: 35,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        AppSpacing.h24(),
                                        AppButton(
                                          height: 30,
                                          expanded: false,
                                          title: 'Watch Videos',
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 12,
                                          ),
                                          suffix: const AppIcon(
                                            icon: AppIconData.film,
                                          ),
                                          onPressed: () =>
                                              controller.searchYoutube(context),
                                        ),
                                        const AppSpacing(h: 6),
                                        AppButton(
                                          height: 30,
                                          expanded: false,
                                          title: 'Save',
                                          color: Colors.white.withOpacity(0.35),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 12,
                                          ),
                                          suffix: const AppIcon(
                                            icon: AppIconData.bookmark,
                                          ),
                                          onPressed: () {},
                                        ),
                                        const AppSpacing(h: 6),
                                        AppButton(
                                          height: 30,
                                          expanded: false,
                                          title: 'Edit ingredients',
                                          color: Colors.white.withOpacity(0.35),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 12,
                                          ),
                                          suffix: const AppIcon(
                                            icon: AppIconData.edit,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SafeArea(
                                child: BackButton(
                                  hasBackground: !collapsed,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppSpacing.v16(),
                    Text(
                      recipe.name,
                      style: AppTextStyle.bold16,
                    ),
                    AppSpacing.v16(),
                    Row(
                      children: [
                        TextWithIcon(
                          text: recipe.cookTime.toTitleCase,
                          icon: AppIconData.timeCheck,
                        ),
                        const AppSpacing(h: 18),
                        TextWithIcon(
                          text: '${recipe.ingredients.length} ingredients',
                          icon: AppIconData.menuBurger,
                        ),
                      ],
                    ),
                    const Divider(height: 36),
                    Text(
                      recipe.description.spaced,
                      style: AppTextStyle.medium14,
                    ),
                    const Divider(height: 36),
                    Text(
                      'Ingredients',
                      style: AppTextStyle.bold16,
                    ),
                    const AppSpacing(v: 14),
                    Text(
                      recipe.ingredients
                          .map((e) => e.name.toCapitalized)
                          .join('\n'),
                      style: AppTextStyle.medium14,
                    ),
                    const Divider(height: 36),
                    Text(
                      'Instructions',
                      style: AppTextStyle.bold16,
                    ),
                    const AppSpacing(v: 14),
                    Text(
                      (recipe.instruction.isNotEmpty
                          ? recipe.instruction.spaced.trim()
                          : recipe.instructions
                              .map((e) => e.spaced.trim().toCapitalized)
                              .join('\n')),
                      style: AppTextStyle.medium14,
                    ),
                    const Divider(height: 36),
                    Text(
                      'Tips',
                      style: AppTextStyle.bold16,
                    ),
                    const AppSpacing(v: 14),
                    Text(
                      recipe.tips.spaced,
                      style: AppTextStyle.medium14,
                    ),
                    AppSpacing.v24(),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}

class BackButton extends StatelessWidget {
  final bool hasBackground;
  const BackButton({
    super.key,
    this.hasBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
          width: hasBackground ? 50 : 30,
          height: hasBackground ? 50 : 30,
          child: Container(
            decoration: BoxDecoration(
              color: hasBackground
                  ? AppColors.primaryColor.withOpacity(0.35)
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: AppIcon(
                icon: AppIconData.back,
                size: 24,
                color: hasBackground ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
