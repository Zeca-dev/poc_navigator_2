import 'package:flutter/material.dart';

class NavigationRoute {
  final String routeName;
  final String titleRoute;
  final Widget page;

  NavigationRoute({
    required this.routeName,
    required this.titleRoute,
    required this.page,
  });
}
