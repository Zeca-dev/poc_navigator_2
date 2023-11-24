import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  PageRouteBuilder navigate() => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => this,
        transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
          position: Tween(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0)).animate(animation),
          child: child,
        ),
      );
}
