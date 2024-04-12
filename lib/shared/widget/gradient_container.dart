import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final List<Color>? colors;
  final List<double>? stops;
  final BoxShape shape;
  final double? radius;
  final EdgeInsets? padding;
  final AlignmentGeometry start;
  final AlignmentGeometry end;
  const GradientContainer({
    super.key,
    this.child,
    this.colors,
    this.stops,
    this.height,
    this.padding,
    this.width,
    this.radius,
    this.shape = BoxShape.rectangle,
    this.start = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: radius != null && shape == BoxShape.rectangle
            ? BorderRadius.circular(radius!)
            : null,
        gradient: LinearGradient(
          begin: start,
          end: end,
          stops: stops ?? [0.0, 0.32, 1.0],
          colors: colors ??
              [
                const Color(0xFFC46780),
                const Color(0xFF8D8FFB),
                const Color(0xFF338AD3),
              ],
        ),
      ),
      child: child,
    );
  }
}
