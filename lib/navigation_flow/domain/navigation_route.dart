// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:poc_navigator_2/navigation_flow/domain/app_transitions.dart';

///Define uma rota para usar no widget `NavigationFlow`.
class NavigationRoute {
  NavigationRoute({
    required this.routeName,
    required this.titlePage,
    required this.page,
    this.transitionType = AppTransitionType.SLIDE_RIGHT_TO_LEFT,
    this.transitionsBuilder,
  })  : assert(routeName.startsWith('/'), r'É necessário passar um nome de rota que comece com /'),
        assert(!(transitionType == AppTransitionType.CUSTOM_TRANSITION && transitionsBuilder == null),
            'Se a transição for custumizada é OBRIGATÓRIO passar o transitionBuilder!'),
        assert(!(transitionType != AppTransitionType.CUSTOM_TRANSITION && transitionsBuilder != null),
            'Se a transição NÁO FOR CUSTOMIZADA náo se deve passar o transitionBuilder!');

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

  ///O [transitionsBuilder] recebee uma animação de transição de rota.
  ///
  /// Essa animação será utilizada para a transição individual de cada
  /// [page] interna da rota base `initialRoute` do `NavigationFlow`.
  ///
  final AppTransition? transitionsBuilder;

  ///Tipo de transição de rota. Define o tipo de animação de rota.
  /// Opções:
  /// [AppTransitionType.SLIDE_BOTTOM_TO_UP]
  /// [AppTransitionType.SLIDE_LEFT_TO_RIGHT]
  /// [AppTransitionType.SLIDE_RIGHT_TO_LEFT]
  /// [AppTransitionType.CUSTOM_TRANSITION]
  ///
  final AppTransitionType transitionType;

  NavigationRoute copyWith({
    String? routeName,
    String? titlePage,
    Widget? page,
    AppTransition? transitionsBuilder,
    AppTransitionType? transitionType,
  }) {
    return NavigationRoute(
      routeName: routeName ?? this.routeName,
      titlePage: titlePage ?? this.titlePage,
      page: page ?? this.page,
      transitionsBuilder: transitionsBuilder ?? this.transitionsBuilder,
      transitionType: transitionType ?? this.transitionType,
    );
  }
}
