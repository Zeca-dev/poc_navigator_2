import 'package:flutter/material.dart';
import 'package:poc_navigator_2/navigator_flow/domain/navigation_route.dart';
import 'package:poc_navigator_2/navigator_flow/domain/navigation_state.dart';
import 'package:poc_navigator_2/navigator_flow/ui/controllers/navigation_controller.dart';

class NavigationFlow extends StatefulWidget {
  const NavigationFlow(
      {super.key,
      required this.initialRoute,
      required this.navigationRoutes,
      this.transitionDuration = const Duration(milliseconds: 300),
      required this.controller});

  final String initialRoute;
  final List<NavigationRoute> navigationRoutes;
  final Duration transitionDuration;
  final NavigationController controller;

  @override
  State<NavigationFlow> createState() => _NavigationFlowState();
}

class _NavigationFlowState extends State<NavigationFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final initialRoute = _getRouteByName(widget.initialRoute);
    widget.controller.setTitlePage(initialRoute?.titlePage ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        widget.controller.removeRoute();

        _navigatorKey.currentState!.pop();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 80),
          child: ValueListenableBuilder<NavigationState>(
            valueListenable: widget.controller,
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
          initialRoute: widget.initialRoute,
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

            widget.controller.addRoute(destinationRoute);
            page = destinationRoute.page;

            return PageRouteBuilder(
              transitionDuration: widget.transitionDuration,
              pageBuilder: (context, animation, secondaryAnimation) => page,
              transitionsBuilder: destinationRoute.transitionsBuilder ??
                  (context, animation, secondaryAnimation, child) => SlideTransition(
                        position: Tween(
                          begin: const Offset(1.0, 0.0),
                          end: const Offset(0.0, 0.0),
                        ).animate(animation),
                        child: child,
                      ),
            );
          },
        ),
      ),
    );
  }

  NavigationRoute? _getRouteByName(String routeName) =>
      widget.navigationRoutes.where((r) => r.routeName == routeName).toList().firstOrNull;
}
