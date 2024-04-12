// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppHero extends StatelessWidget {
  final String tag;
  final Widget child;
  const AppHero({
    super.key,
    required this.tag,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        return Material(
          child: DefaultTextStyle(
            style: DefaultTextStyle.of(toHeroContext).style,
            child: toHeroContext.widget,
          ),
        );
      },
      child: child,
    );
  }
}
