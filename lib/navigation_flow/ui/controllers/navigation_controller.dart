// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:poc_navigator_2/navigation_flow/domain/navigation_route.dart';

///Controlador de estado do fluxo de navegação.
/// Contém uma `navigationRouteStack` que guarda as rotas
/// do fluxo atual. Este [controller] também é usado para
/// alterar o título das páginas do fluxo em qualquer parte
/// do mesmo, desde que receba uma instância global `singleton`
/// de [NavigationController]. Caso não seja fornecido, o
/// [NavigationFlow] terá uma instância interna de [NavigatrionController],
/// a qual sempre utilizará os títulos de rota `fixos`,
/// fornecidos em cada `navigationRoute` da lista [navigationRoutes].
///
///
class NavigationController extends ValueNotifier<_NavigationState> {
  NavigationController() : super(_NavigationState(titlePage: '', navigationRouteStack: []));

  ///Adiciona uma [route] à [navigationRouteStack] se a mesma
  ///aidna não estiver na pilha.
  ///
  addRoute(NavigationRoute route) {
    if (!value.navigationRouteStack.contains(route)) {
      value.navigationRouteStack.add(route);
    }
    setTitlePage(value.navigationRouteStack.last.titlePage);
  }

  ///Remove uma rota da [navigationRouteStack].
  ///
  removeRoute() {
    if (value.navigationRouteStack.isNotEmpty) {
      value.navigationRouteStack.removeLast();
      setTitlePage(value.navigationRouteStack.last.titlePage);
    }
  }

  ///Define o [tile] para a [page] atual da rota.
  ///
  setTitlePage(String title) {
    value = value.copyWith(titlePage: title);
  }
}

///Representa o estado de uma navegação no [NavigationFlow].
class _NavigationState {
  ///Pilha que contém as [navigationRoutes].
  ///
  final List<NavigationRoute> navigationRouteStack;

  ///Título de uma [page].
  ///
  final String titlePage;

  _NavigationState({
    required this.titlePage,
    required this.navigationRouteStack,
  });

  _NavigationState copyWith({
    List<NavigationRoute>? navigationRouteStack,
    String? titlePage,
  }) {
    return _NavigationState(
      navigationRouteStack: navigationRouteStack ?? this.navigationRouteStack,
      titlePage: titlePage ?? this.titlePage,
    );
  }
}
