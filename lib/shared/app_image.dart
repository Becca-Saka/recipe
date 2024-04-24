import 'package:flutter/material.dart';
import 'package:recipe/shared/app_icons.dart';
import 'package:shimmer/shimmer.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.radius = 5,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final double radius;
  bool get isAsset => imageUrl.startsWith('asset');
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Builder(builder: (context) {
        if (isAsset) {
          return Container(
            width: width,
            height: height,
            color: const Color(0xFFEEEEEE),
            // color: Colors.grey.shade200,
            child: Center(
              child: AppIcon(
                icon: imageUrl,
                size: 12,
              ),
            ),
          );
        }
        return Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                color: Colors.white,
                width: width,
                height: height,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: const Color(0xFFEEEEEE),
              // color: Colors.grey.shade200,
              child: const Center(
                child: AppIcon(
                  icon: AppIconData.picture,
                  size: 24,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
