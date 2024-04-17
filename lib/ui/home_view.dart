import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/user_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_image.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/extensions/string.dart';
import 'package:recipe/shared/widget/app_transparent_button.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';
import 'package:recipe/shared/widget/gradient_container.dart';
import 'package:recipe/shared/widget/icon_with_text.dart';
import 'package:recipe/ui/collect_ingredient_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getUserRecipes(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    final isSmall = height < 700 && width < 400;
    return Consumer<UserProvider>(builder: (context, controller, child) {
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const CustomAppBar(
                  title: 'Recipé',
                  titleTextSize: 24,
                  hasBackButton: false,
                  waterMarked: false,
                  actions: AppIcon(
                    icon: AppIconData.notifications,
                    size: 24,
                  ),
                ),
                const AppSpacing(v: 16),
                Expanded(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GradientContainer(
                            radius: 15,
                            width: double.infinity,
                            stops: const [
                              0.2,
                              0.7,
                              1.0,
                            ],
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            colors: const [
                              Color(0xFF72B8F4),
                              Color(0xFFCF5EEE),
                              Color(0xFF8F90F2),
                            ],
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                // width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Hey Jon',
                                      style: AppTextStyle.medium14.copyWith(
                                          color: const Color(0xFFFFBDC1)),
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
                                      text:
                                          '${controller.sugestedRecipeList.length} recipe(s) generated',
                                      icon: AppIconData.timePast,
                                      textStyle: AppTextStyle.medium10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: -22,
                            child: Image.asset(
                              'assets/images/boy-cook.png',
                              width: 131,
                              height: 128,
                            ),
                          ),
                        ],
                      ),
                      const AppSpacing(v: 16),
                      TransparentButton(
                        title: 'Generate a new recipe',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CollectIngredientView(),
                            ),
                          );
                        },
                        suffix: const AppIcon(
                          icon: AppIconData.forward,
                          size: 24,
                        ),
                        prefix: const GradientContainer(
                          height: 29,
                          width: 29,
                          shape: BoxShape.circle,
                          child: Center(
                            child: AppIcon(
                              icon: AppIconData.redoSpark,
                              size: 10,
                            ),
                          ),
                        ),
                      ),
                      const Divider(height: 42),
                      TextWithIcon(
                        text: 'Previous recipes',
                        icon: AppIconData.timePast,
                        textStyle: AppTextStyle.medium14,
                      ),
                      if (controller.isLoading)
                        const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
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
                            itemCount: controller.sugestedRecipeList.length,
                            itemBuilder: (context, index) {
                              final item = controller.sugestedRecipeList[index];
                              return InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  controller.viewRecipeDetails(item, context);
                                },
                                child: SizedBox(
                                  height: 136,
                                  child: Stack(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: AppImage(
                                              height: 136,
                                              // width: 91,
                                              imageUrl: item.imageUrl ?? '',
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              height: 206,
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.4),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          child: Flexible(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.name.toTitleCase,
                                                  style: AppTextStyle.bold16
                                                      .copyWith(
                                                    fontSize: 14,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                if (item.dateSuggested != null)
                                                  const AppSpacing(v: 4),
                                                if (item.dateSuggested != null)
                                                  Text(
                                                    item.dateSuggested!
                                                        .toString()
                                                        .formatDate,
                                                    textAlign: TextAlign.start,
                                                    // overflow: TextOverflow.ellipsis,
                                                    style: AppTextStyle.bold16
                                                        .copyWith(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Stack(
                                      //   children: [
                                      //     ClipRRect(
                                      //       borderRadius: BorderRadius.circular(12),
                                      //       child: Container(
                                      //         height: 206,
                                      //         // width: 91,
                                      //         color:
                                      //             AppColors.primaryColor.withOpacity(
                                      //           0.4,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     const AppIcon(
                                      //       icon: AppIconData.youtube,
                                      //       size: 28,
                                      //       color: Colors.amber,
                                      //     ),
                                      //   ],
                                      // ),
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
