import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color? color;
  final VoidCallback? onTap;
  const AppIcon({
    required this.icon,
    super.key,
    this.size = 16,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        icon,
        width: size,
        height: size,
        color: color,
      ),
    );
  }
}

abstract class AppIconData {
  static const String _svgBase = 'assets/svgs/';
  static const String back = '$_svgBase/back.svg';
  static const String redoSpark = '$_svgBase/redo-spark.svg';
}
