// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

///Define uma rota para usar no widget `NavigationFlow`.
class NavigationRoute {
  NavigationRoute({
    required this.routeName,
    required this.titlePage,
    required this.page,
  }) : assert(routeName.startsWith('/'), 'É necessário passar um nome de rota que comece com /');

  ///Nome da rota, o qual será utilizado para navegar
  /// para a [page]
  ///
  final String routeName;

  ///O [titlePage] é o nome que será utilizado na página da rota.
  /// Se o `NavigationFlow` receber um `NavigationController` global, `singleton`,
  /// será possível alterar o título da página de qualquer lugar do
  /// fluxo de navegação. Caso contrário esses títulos serão fixos.
  ///
  final String titlePage;

  ///Widget [page] que será renderizado quando a rota receber a navegação.
  ///
  final Widget page;

  NavigationRoute copyWith({
    String? routeName,
    String? titlePage,
    Widget? page,
  }) {
    return NavigationRoute(
      routeName: routeName ?? this.routeName,
      titlePage: titlePage ?? this.titlePage,
      page: page ?? this.page,
    );
  }
}
