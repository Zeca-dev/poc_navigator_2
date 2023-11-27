import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ///Extensões sobre o BuildContext
  ///
  ///
  ///Navega para uma nova route [route]
  ///
  Future<T?> push<T extends Object?>(Route<T> route) => Navigator.push(this, route);

  ///Navega para uma [routeNamed].
  ///
  Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  /// Remove uma rota da pilha, podendo retornar um T?
  /// Se [rootNavigator] for true irá utilizar o navigator global.
  /// Default: [false]
  ///
  void pop<T extends Object?>({bool rootNavigator = false, T? result}) {
    if (rootNavigator) {
      Navigator.of(this, rootNavigator: rootNavigator).pop(result);
    } else {
      Navigator.pop(this, result);
    }
  }
}
