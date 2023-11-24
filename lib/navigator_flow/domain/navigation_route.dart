import 'package:flutter/material.dart';

class NavigationRoute {
  final String routeName;
  final String titlePage;
  final Widget page;
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transitionsBuilder;

  NavigationRoute({
    required this.routeName,
    required this.titlePage,
    required this.page,
    this.transitionsBuilder,
  });
}
