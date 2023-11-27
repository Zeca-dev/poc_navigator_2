import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ///Extensões sobre o BuildContext
  ///

  ///Recupera um argumento [argument] passado em uma rota.
  /// Se não for passado nenhum argumento o valor será [Null].
  ///
  T? getArgs<T extends Object?>() {
    final argument = ModalRoute.of(this)?.settings.arguments as T?;
    return argument;
  }

  ///Navega para uma nova route [route]. Se [rootNavigator] for true irá
  /// utilizar o navegador global. Default: `rootNavigator = false`.
  ///
  Future<T?> push<T extends Object?>(Route<T> route, {bool rootNavigator = false}) => //
      switch (rootNavigator) {
        true => Navigator.of(this, rootNavigator: rootNavigator).push(route),
        false => Navigator.push(this, route),
      };

  ///Navega para uma [routeNamed].Se [rootNavigator] for true irá
  /// utilizar o navegador global. Default: `rootNavigator = false`.
  ///
  Future<T?> pushNamed<T extends Object?>(String routeName, {bool rootNavigator = false, Object? arguments}) =>
      switch (rootNavigator) {
        true => Navigator.of(this, rootNavigator: rootNavigator).pushNamed(routeName, arguments: arguments),
        false => Navigator.pushNamed(this, routeName, arguments: arguments),
      };

  /// Remove uma rota da pilha, podendo retornar um T?
  /// Se [rootNavigator] Se [rootNavigator] for true irá
  /// utilizar o navegador global. Default: `rootNavigator = false`.
  ///
  void pop<T extends Object?>({bool rootNavigator = false, T? result}) => //
      switch (rootNavigator) {
        true => Navigator.of(this, rootNavigator: rootNavigator).pop(result),
        false => Navigator.pop(this, result),
      };
}
