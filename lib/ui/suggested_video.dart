import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/recipe_provider.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:recipe/shared/app_image.dart';
import 'package:recipe/shared/app_spacing.dart';
import 'package:recipe/shared/app_text_style.dart';
import 'package:recipe/shared/extensions/num.dart';
import 'package:recipe/shared/extensions/string.dart';
import 'package:recipe/shared/widget/custom_app_bar.dart';

class SuggestedVideosView extends StatelessWidget {
  const SuggestedVideosView({super.key});

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
                  CustomAppBar(
                    title: 'Suggested videos',
                    waterMark: Image.asset(
                      'assets/images/youtube_logo.png',
                      height: 14,
                      width: 63,
                    ),
                  ),
                  const AppSpacing(v: 16),
                  if (controller.loading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          mainAxisExtent: 206,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        itemCount: controller.youtubeData.length,
                        itemBuilder: (context, index) {
                          final item = controller.youtubeData[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              controller.playVideo(item, context);
                            },
                            child: SizedBox(
                              height: 206,
                              child: Stack(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: AppImage(
                                          height: 206,
                                          imageUrl: item.imageUrl,
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          height: 206,
                                          color: AppColors.primaryColor
                                              .withOpacity(
                                            0.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/youtube_icon.png',
                                          width: 28,
                                          height: 18,
                                        ),
                                        const AppIcon(
                                          icon: AppIconData.youtube,
                                          size: 28,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.title.toTitleCase,
                                                style: AppTextStyle.bold16
                                                    .copyWith(
                                                  fontSize: 14,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '${item.viewCount.minify} views',
                                                    style: AppTextStyle.bold16
                                                        .copyWith(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 3,
                                                    width: 3,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  // const AppSpacing(h: 18),
                                                  Expanded(
                                                    child: Text(
                                                      item.publishTime
                                                          .formatDate,
                                                      textAlign:
                                                          TextAlign.start,
                                                      // overflow: TextOverflow.ellipsis,
                                                      style: AppTextStyle.bold16
                                                          .copyWith(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
