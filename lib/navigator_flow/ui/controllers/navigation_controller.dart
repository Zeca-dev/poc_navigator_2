// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:poc_navigator_2/navigator_flow/domain/navigation_route.dart';
import 'package:poc_navigator_2/navigator_flow/domain/navigation_state.dart';

class NavigationController extends ValueNotifier<NavigationState> {
  NavigationController() : super(NavigationState(titlePage: '', navigationRouteStack: []));

  addRoute(NavigationRoute route) {
    if (!value.navigationRouteStack.contains(route)) {
      value.navigationRouteStack.add(route);
    }
    setTitlePage(value.navigationRouteStack.last.titlePage);
  }

  removeRoute() {
    if (value.navigationRouteStack.isNotEmpty) {
      value.navigationRouteStack.removeLast();
      setTitlePage(value.navigationRouteStack.last.titlePage);
    }
  }

  setTitlePage(String title) {
    value = value.copyWith(titlePage: title);
  }
}
