import 'package:flutter/material.dart';

import '../../domain/navigation_route.dart';

part '../controllers/navigation_flow_controller.dart';

class NavigationFlow extends StatefulWidget {
  ///Widget que cria um fluxo de navegação.
  ///
  ///contém uma rota inicial [initialRoute] e uma
  /// lista de rotas navegáveis [navigationRoutes].
  ///
  const NavigationFlow({
    super.key,
    this.appBarEnabled = true,
    this.initialRoute,
    required this.navigationRoutes,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.onCloseMethod,
  }) : assert(navigationRoutes.length > 1, 'A pilha [navigationRoutes] deve ter pelo menos duas rotas!');

  /// Define se a AppBar será exibida.
  ///
  final bool appBarEnabled;

  ///Rota onde o fluxo de navegação inicia.
  /// Caso [initialRoute] não seja fornecida, será usada a primeira
  /// rota contida em [navigationRoutes].
  ///
  final String? initialRoute;

  ///Lista de Rotas que compõem o fluxo de navegação.
  /// Deve conter pelo menos duas rotas.
  ///
  final List<NavigationRoute> navigationRoutes;

  ///Duração das animações de rota dentro do fluxo de navegação.
  /// Valor default: `Duration(miliseconds: 300)`
  ///
  final Duration transitionDuration;

  ///Controlador de estado do fluxo de navegação.
  /// Contém uma `navigationRouteStack` que guarda as rotas
  /// do fluxo atual. Este [_controller] também é usado para
  /// alterar o título das páginas do fluxo em qualquer parte
  /// do mesmo.
  ///
  static final List<_NavigationFlowController> _controllers = [];

  ///Retorna a [NavigationRoute] atual do fluxo.
  /// Retorna [initialRoute] caso a pilha esteja vazia.
  ///
  static NavigationRoute currentRoute() => _controllers.last.currentRoute();

  /// Atualiza o títiulo [title] de uma página do fluxo de navvegação.
  /// Utilize [setTitlePage] apenas em views que estão dentro de um fluxo de
  /// navegação [NavigationFlow].
  ///
  ///
  static void setTitlePage(String title) => _controllers.last.setTitlePage(title);

  /// Remove todas as rotas da stack até parar em [routeName].
  ///
  /// Caso a [routeName] não exista no NavigationFlow irá retornar um ArgumentError.
  ///
  static void backToRoute(String routeName) {
    final route = _getRouteByName(routeName);
    if (route == null) {
      throw ArgumentError('A Rota "$routeName" não existe neste NavigationFlow!');
    }

    _controllers.last.removeRoutesUntil(routeName);
  }

  /// Método executado ao clicar no botão de fechar.
  ///
  final Future<bool> Function()? onCloseMethod;

  @override
  State<NavigationFlow> createState() => _NavigationFlowState();
}

class _NavigationFlowState extends State<NavigationFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late _NavigationFlowController _internalController;
  late NavigationRoute _initialRoute;

  bool _canPopRoot = true;

  @override
  void initState() {
    final controller = _NavigationFlowController();
    controller.value.navigatorKey = _navigatorKey;

    controller.value.navigationRoutes.addAll(widget.navigationRoutes);
    NavigationFlow._controllers.add(controller);

    _internalController = NavigationFlow._controllers.last;

    _initialRoute = _getRouteByName(_getInitialRouteName()) ?? widget.navigationRoutes.first;
    _internalController.setTitlePage(_initialRoute.titlePage);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _internalController.addListener(_enableRootCanPop);
    });

    super.initState();
  }

  void _enableRootCanPop() {
    setState(() {
      _canPopRoot = _internalController.value.navigationRouteStack.length == 1;
    });
  }

  @override
  void dispose() {
    NavigationFlow._controllers.removeLast();
    _internalController.dispose();
    super.dispose();
  }

  String _getInitialRouteName() {
    switch (widget.initialRoute) {
      case null:
        return widget.navigationRoutes.first.routeName;
      case _:
        if (widget.initialRoute!.isEmpty) {
          return widget.navigationRoutes.first.routeName;
        }
        return widget.initialRoute!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPopRoot,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        _pop();
      },
      child: Scaffold(
        appBar: !widget.appBarEnabled
            ? null
            : PreferredSize(
                preferredSize: Size(MediaQuery.sizeOf(context).width, 55),
                child: ValueListenableBuilder(
                  valueListenable: _internalController,
                  builder: (context, state, child) => AppBar(
                    automaticallyImplyLeading: state.navigationRouteStack.length > 1,
                    backgroundColor: Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
                    centerTitle: false,
                    title: Text(state.navigationRouteStack.last.titlePage),
                    leading: _canPopRoot
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              _navigatorKey.currentState!.pop();
                            },
                          ),
                    actions: [
                      IconButton(
                        onPressed: () async {
                          if (widget.onCloseMethod == null) {
                            Navigator.of(context).pop();
                            return;
                          }

                          final result = await widget.onCloseMethod!.call();
                          if (result) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
              ),

        //
        body: Navigator(
          key: _navigatorKey,
          initialRoute: _initialRoute.routeName,
          onGenerateRoute: (settings) {
            var route = settings.name;
            Widget page;

            if (route == null) {
              return null;
            }

            NavigationRoute? destinationRoute = _getRouteByName(route);

            if (destinationRoute == null) {
              return null;
            }

            _internalController.addToStack(destinationRoute);
            page = destinationRoute.page;

            return MaterialPageRoute(
              settings: settings,
              builder: (context) => PopScope(
                canPop: true,
                onPopInvokedWithResult: (didPop, result) async {
                  if (didPop) {
                    if (_internalController.value.navigationRouteStack.length > 1) {
                      _internalController.removeFromStack();
                    }
                    return;
                  }

                  _pop();
                },
                child: page,
              ),
            );
          },
        ),
      ),
    );
  }

  void _pop() {
    if (_canPopRoot) {
      Navigator.of(context).pop();
      return;
    } else {
      _internalController.removeFromStack();
    }
  }
}

NavigationRoute? _getRouteByName(String routeName) =>
    NavigationFlow._controllers.last.value.navigationRoutes.where((r) => r.routeName == routeName).toList().firstOrNull;
