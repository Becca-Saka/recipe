import 'package:flutter/material.dart';
import 'package:recipe/data/services/pexels_api_service.dart';
import 'package:recipe/shared/app_image.dart';
import 'package:shimmer/shimmer.dart';

class AppPexelImage extends StatefulWidget {
  const AppPexelImage({
    super.key,
    required this.name,
    this.width,
    this.height,
    this.radius = 5,
  });

  final String name;
  final double? width;
  final double? height;
  final double radius;

  @override
  State<AppPexelImage> createState() => _AppPexelImageState();
}

class _AppPexelImageState extends State<AppPexelImage> {
  String? url;
  bool isLoading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void _updateLoading(bool value) {
    if (mounted) {
      setState(() {
        isLoading = value;
      });
    }
  }

  Future<void> getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      url = await PexelsApiService().getPicture(widget.name);
      _updateLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          color: Colors.white,
          width: widget.width,
          height: widget.height,
        ),
      );
    }
    return AppImage(
      imageUrl: url ?? '',
      width: widget.width,
      height: widget.height,
      radius: widget.radius,
    );
  }
}
