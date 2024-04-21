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

  ///Retorna a [NavigationRoute] atual do fluxo.
  /// Retorna [initialRoute] caso a pilha esteja vazia.
  ///
  NavigationRoute currentRoute() {
    if (value.navigationRouteStack.isNotEmpty) {
      return value.navigationRouteStack.last;
    }
    return value.navigationRoutes.first;
  }

  ///Define o [title] para a [page] atual da rota.
  ///
  void setTitlePage(String title) {
    if (value.navigationRouteStack.isNotEmpty) {
      final route = currentRoute().copyWith(titlePage: title);
      value.navigationRouteStack.removeLast();
      value.navigationRouteStack.add(route);
      value = value.copyWith(titlePage: title);
    } else {
      value = value.copyWith(titlePage: title);
    }
  }
}

///Representa o estado de uma navegação no [NavigationFlow].
///
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
