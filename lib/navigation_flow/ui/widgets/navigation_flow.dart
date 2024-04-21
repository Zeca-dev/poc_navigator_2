import 'package:flutter/material.dart';

import '../../domain/app_transitions.dart';
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
    required this.initialRoute,
    required this.navigationRoutes,
    this.transitionDuration = const Duration(milliseconds: 300),
  }) : assert(navigationRoutes.length > 1, 'A pilha [navigationRoutes] deve ter pelo menos duas rotas!');

  /// Define se a AppBar estará habilitada.
  ///
  final bool appBarEnabled;

  ///Rota onde o fluxo de navegação inicia.
  /// Caso [initialRoute] não seja fornecida, será usada a primeira
  /// rota contida em [navigationRoutes].
  ///
  final String initialRoute;

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

  @override
  State<NavigationFlow> createState() => _NavigationFlowState();
}

class _NavigationFlowState extends State<NavigationFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late _NavigationFlowController _internalController;

  @override
  void initState() {
    final controller = _NavigationFlowController();
    controller.value.navigationRoutes.addAll(widget.navigationRoutes);
    NavigationFlow._controllers.add(controller);

    _internalController = NavigationFlow._controllers.last;
    // _internalController.value.navigationRouteStack.clear();

    final initialRoute = _getRouteByName(widget.initialRoute);
    _internalController.setTitlePage(initialRoute?.titlePage ?? widget.navigationRoutes.first.titlePage);

    super.initState();
  }

  @override
  void dispose() {
    NavigationFlow._controllers.removeLast();
    _internalController.dispose();
    super.dispose();
  }

  NavigationRoute? _getRouteByName(String routeName) => NavigationFlow._controllers.last.value.navigationRoutes
      .where((r) => r.routeName == routeName)
      .toList()
      .firstOrNull;
  // widget.navigationRoutes.where((r) => r.routeName == routeName).toList().firstOrNull;

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        _internalController.removeFromStack();
        _navigatorKey.currentState!.pop();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: !widget.appBarEnabled
              ? null
              : PreferredSize(
                  preferredSize: Size(MediaQuery.sizeOf(context).width, 55),
                  child: ValueListenableBuilder(
                    valueListenable: _internalController,
                    builder: (context, state, child) => AppBar(
                      automaticallyImplyLeading: state.navigationRouteStack.length > 1,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      title: Text(state.navigationRouteStack.last.titlePage),
                      actions: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ),

          //
          body: Navigator(
            key: _navigatorKey,
            initialRoute:
                widget.initialRoute.isNotEmpty ? widget.initialRoute : widget.navigationRoutes.first.routeName,
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

              return switch (destinationRoute.transitionType) {
                AppTransitionType.SLIDE_BOTTOM_TO_UP => SlideBottomToUp(
                    settings: settings,
                    page: page,
                    duration: widget.transitionDuration,
                  ),
                AppTransitionType.SLIDE_RIGHT_TO_LEFT => SlideRightToLeft(
                    settings: settings,
                    page: page,
                    duration: widget.transitionDuration,
                  ),
                AppTransitionType.SLIDE_LEFT_TO_RIGHT => SlideLeftToRight(
                    settings: settings,
                    page: page,
                    duration: widget.transitionDuration,
                  ),
                AppTransitionType.CUSTOM_TRANSITION => CustomTransition(
                    settings: settings,
                    page: page,
                    duration: widget.transitionDuration,
                    transition: destinationRoute.transitionsBuilder!,
                  )
              };
            },
          ),
        ),
      ),
    );
  }
}
