part of '../widgets/navigation_flow.dart';

class _NavigationFlowController extends ValueNotifier<_NavigationState> {
  _NavigationFlowController() : super(_NavigationState(titlePage: '', navigationRoutes: [], navigationRouteStack: []));

  ///Adiciona uma [route] à [navigationRouteStack] se a mesma
  ///aidna não estiver na pilha.
  ///
  void addToStack(NavigationRoute route) {
    if (!value.navigationRouteStack.contains(route)) {
      value.navigationRouteStack.add(route);
    }
    setTitlePage(value.navigationRouteStack.last.titlePage);
  }

  ///Remove uma rota da [navigationRouteStack].
  ///
  void removeFromStack() {
    if (value.navigationRouteStack.isNotEmpty) {
      value.navigationRouteStack.removeLast();
      if (value.navigationRouteStack.isNotEmpty) {
        setTitlePage(value.navigationRouteStack.last.titlePage);
      }
    }
  }

  ///Define o [title] para a [page] atual da rota.
  ///
  void setTitlePage(String title) {
    if (value.navigationRouteStack.isNotEmpty) {
      List<NavigationRoute> stack = value.navigationRouteStack;
      final route = stack.last.copyWith(titlePage: title);
      stack.removeLast();
      stack.add(route);

      value = value.copyWith(titlePage: title, navigationRouteStack: stack);
    } else {
      value = value.copyWith(titlePage: title);
    }
  }
}

///Representa o estado de uma navegação no [NavigationFlow].
class _NavigationState {
  ///Lista de [navigationRoutes] do fluxo atual.
  ///
  final List<NavigationRoute> navigationRoutes;

  ///Pilha que contém as [navigationRoutes] ativas.
  ///
  final List<NavigationRoute> navigationRouteStack;

  ///Título de uma [page].
  ///
  final String titlePage;

  _NavigationState({
    required this.titlePage,
    required this.navigationRoutes,
    required this.navigationRouteStack,
  });

  _NavigationState copyWith({
    List<NavigationRoute>? navigationRoutes,
    List<NavigationRoute>? navigationRouteStack,
    String? titlePage,
  }) {
    return _NavigationState(
      navigationRoutes: navigationRoutes ?? this.navigationRoutes,
      navigationRouteStack: navigationRouteStack ?? this.navigationRouteStack,
      titlePage: titlePage ?? this.titlePage,
    );
  }
}
