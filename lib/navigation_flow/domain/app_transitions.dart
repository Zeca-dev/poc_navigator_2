// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

///Definição de tipo para uma Animação de rota `transitionBuilder`.
///
typedef AppTransition = Widget Function(
    BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child);

///Tipos de transição de rota.
///
enum AppTransitionType {
  SLIDE_BOTTOM_TO_UO,
  SLIDE_LEFT_TO_RIGHT,
  SLIDE_RIGHT_TO_LEFT,
  CUSTOM_TRANSITION,
}

///Transição da direita para a esquerda
///
class SlideRightToLeft extends PageRouteBuilder {
  final Widget page;
  final Duration duration;

  SlideRightToLeft({
    required this.page,
    this.duration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return page;
          },
          transitionDuration: duration,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
        );
}

///Transição da esquerda para a direira
///
class SlideLeftToRight extends PageRouteBuilder {
  final Widget page;
  final Duration duration;

  SlideLeftToRight({
    required this.page,
    super.settings,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return page;
            },
            transitionDuration: duration,
            transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}

///Transição de baixo para cima
///
class SlideBottomToUp extends PageRouteBuilder {
  final Widget page;
  final Duration duration;

  SlideBottomToUp({
    required this.page,
    super.settings,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return page;
            },
            transitionDuration: duration,
            transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}

///Transição customizada. É obrigatório pasar a transição customizada [transition].
///
class CustomTransition extends PageRouteBuilder {
  final Widget page;
  final Duration duration;
  final AppTransition transition;

  CustomTransition({
    required this.page,
    required this.transition,
    super.settings,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return page;
          },
          transitionDuration: duration,
          transitionsBuilder: transition,
        );
}
