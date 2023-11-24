import 'package:flutter/material.dart';
import 'package:poc_navigator_2/navigation_flow/domain/app_transitions.dart';
import 'package:poc_navigator_2/navigation_flow/domain/navigation_route.dart';
import 'package:poc_navigator_2/navigation_flow/ui/controllers/navigation_controller.dart';

class NavigationFlow extends StatefulWidget {
  ///Widget que cria um fluxo de navegação.
  ///
  ///contém uma rota inicial [initialRoute] e uma
  /// lista de rotas navegáveis [navigationRoutes].
  ///
  const NavigationFlow(
      {super.key,
      required this.initialRoute,
      required this.navigationRoutes,
      this.transitionDuration = const Duration(milliseconds: 300),
      this.controller})
      : assert(navigationRoutes.length > 1, 'A pilha [navigationRoutes] deve ter pelo menos duas rotas!');

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
  /// do fluxo atual. Este [controller] também é usado para
  /// alterar o título das páginas do fluxo em qualquer parte
  /// do mesmo, desde que receba uma instância global `singleton`
  /// de [NavigationController]. Caso não seja fornecido, o
  /// [NavigationFlow] terá uma instância interna de [NavigatrionController],
  /// a qual sempre utilizará os títulos de rota `fixos`,
  /// fornecidos em cada `navigationRoute` da lista [navigationRoutes].
  ///
  final NavigationController? controller;

  @override
  State<NavigationFlow> createState() => _NavigationFlowState();
}

class _NavigationFlowState extends State<NavigationFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late NavigationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? NavigationController();

    final initialRoute = _getRouteByName(widget.initialRoute);
    _controller.setTitlePage(initialRoute?.titlePage ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        _controller.removeRoute();

        _navigatorKey.currentState!.pop();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 80),
          child: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, state, child) => AppBar(
              title: Text(state.titlePage),
              leading: state.navigationRouteStack.length == 1 ? Container() : null,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
        ),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.initialRoute.isNotEmpty ? widget.initialRoute : widget.navigationRoutes.first.routeName,
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

            _controller.addRoute(destinationRoute);
            page = destinationRoute.page;

            return switch (destinationRoute.transitionType) {
              AppTransitionType.SLIDE_BOTTOM_TO_UO => SlideBottomToUp(
                  page: page,
                  duration: widget.transitionDuration,
                ),
              AppTransitionType.SLIDE_RIGHT_TO_LEFT => SlideRightToLeft(
                  page: page,
                  duration: widget.transitionDuration,
                ),
              AppTransitionType.SLIDE_LEFT_TO_RIGHT => SlideLeftToRight(
                  page: page,
                  duration: widget.transitionDuration,
                ),
              AppTransitionType.CUSTOM_TRANSITION => CustomTransition(
                  page: page,
                  duration: widget.transitionDuration,
                  transition: destinationRoute.transitionsBuilder!,
                )
            };
          },
        ),
      ),
    );
  }

  NavigationRoute? _getRouteByName(String routeName) =>
      widget.navigationRoutes.where((r) => r.routeName == routeName).toList().firstOrNull;
}
