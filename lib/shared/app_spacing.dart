import 'package:flutter/material.dart';

class AppSpacing extends StatelessWidget {
  const AppSpacing({
    ///vertical space
    this.v = 0,

    ///horizontal space
    this.h = 0,
    super.key,
  });

  factory AppSpacing.h8() => const AppSpacing(h: 8);
  factory AppSpacing.v8() => const AppSpacing(v: 8);
  factory AppSpacing.h16() => const AppSpacing(h: 16);
  factory AppSpacing.v16() => const AppSpacing(v: 16);
  factory AppSpacing.v24() => const AppSpacing(v: 24);
  factory AppSpacing.h24() => const AppSpacing(h: 24);
  factory AppSpacing.h32() => const AppSpacing(h: 32);
  factory AppSpacing.h30() => const AppSpacing(h: 30);
  factory AppSpacing.v32() => const AppSpacing(v: 32);

  final int v;
  final int h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: v.toDouble(),
      width: h.toDouble(),
    );
  }
}
