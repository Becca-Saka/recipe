// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

class GradientData {
  final Color color;
  final Offset offset;
  final double radius;
  const GradientData({
    required this.color,
    required this.offset,
    required this.radius,
  });
}

class GradientBackground extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final bool mask;
  final double? width, height;
  final double? clipRadius;
  final List<GradientData> colors;
  const GradientBackground({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.colors,
    this.height,
    this.width,
    this.clipRadius,
    this.mask = true,
  });

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground> {
  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   width: widget.width,
    //   height: widget.height,
    //   child: Material(
    //     child: Stack(
    //       children: [
    //         CustomPaint(
    //           size: widget.width != null && widget.height != null
    //               ? Size(widget.width!, widget.height!)
    //               : Size.zero,
    //           painter: BackgroundPainter(
    //             backgroundColor: widget.backgroundColor,
    //             colors: widget.colors,
    //           ),
    //           child: SizedBox(
    //             width: widget.width,
    //             height: widget.height,
    //           ),
    //         ),
    //         // BackdropFilter(
    //         //   filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
    //         //   child: Container(
    //         //     color: Colors.black.withOpacity(0.1),
    //         //   ),
    //         // ),
    //         widget.child,
    //       ],
    //     ),
    //   ),
    // );

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.clipRadius ?? 0),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Material(
          child: Stack(
            children: [
              CustomPaint(
                size: widget.width != null && widget.height != null
                    ? Size(widget.width!, widget.height!)
                    : Size.zero,
                painter: BackgroundPainter(
                  backgroundColor: widget.backgroundColor,
                  colors: widget.colors,
                  mask: widget.mask,
                ),
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Color backgroundColor;
  final List<GradientData> colors;
  final bool mask;
  BackgroundPainter({
    required this.backgroundColor,
    required this.colors,
    required this.mask,
  });

  void drawCircle(
    GradientData data,
    Canvas canvas,
    Size size,
    Paint paint,
  ) {
    paint.color = data.color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;

    paint.style = PaintingStyle.fill;

    canvas.drawCircle(data.offset, data.radius, paint);
  }

  void drawContrastingBlobs(Canvas canvas, Size size, Paint paint) {
    if (mask) {
      paint.maskFilter = const MaskFilter.blur(BlurStyle.outer, 200);
    }

    for (var color in colors) {
      drawCircle(color, canvas, size, paint);
    }
    // var offset = Offset(0, size.width / 2);
    // var color = const Color(0xFFCF5EEE);
    // drawCircle(canvas, size, paint, offset, color);
    // offset = Offset(size.width + 60, size.height / 2);
    // color = const Color(0xFF8F90F2);
    // drawCircle(canvas, size, paint, offset, color);
    // offset = Offset(size.width / 2, size.height);
    // color = const Color(0xFF72B8F4);
    // drawCircle(canvas, size, paint, offset, color);
  }

  void paintBackground(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.5),
          width: size.width,
          height: size.height,
        ),
        Paint()..color = const Color(0xFF131314));
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintBackground(canvas, size);
    // drawAbstractShapes(canvas, size);
    final paint = Paint();
    drawContrastingBlobs(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
