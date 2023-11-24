import 'package:poc_navigator_2/navigator_flow/domain/navigation_route.dart';

class NavigationState {
  final List<NavigationRoute> navigationRouteStack;
  final String titlePage;

  NavigationState({
    required this.titlePage,
    required this.navigationRouteStack,
  });

  NavigationState copyWith({
    List<NavigationRoute>? navigationRouteStack,
    String? titlePage,
  }) {
    return NavigationState(
      navigationRouteStack: navigationRouteStack ?? this.navigationRouteStack,
      titlePage: titlePage ?? this.titlePage,
    );
  }
}
