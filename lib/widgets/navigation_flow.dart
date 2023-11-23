import 'package:flutter/material.dart';

import 'package:poc_navigator_2/widgets/navigationRoute.dart';

class NavigationFlow extends StatefulWidget {
  const NavigationFlow({
    super.key,
    required this.initialRoute,
    required this.navigationRoutes,
  });

  final String initialRoute;
  final List<NavigationRoute> navigationRoutes;

  @override
  State<NavigationFlow> createState() => _NavigationFlowState();
}

class _NavigationFlowState extends State<NavigationFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final _navigationRouteStack = <NavigationRoute>[];

  final title = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    title.value = widget.initialRoute;
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        if (_navigationRouteStack.isNotEmpty) {
          _navigationRouteStack.removeLast();
          title.value = _navigationRouteStack.last.titleRoute;
        }
        _navigatorKey.currentState!.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListenableBuilder(
            builder: (context, child) => Text(title.value),
            listenable: title,
          ),
          // leading: Container(),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close))
          ],
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

            NavigationRoute? destinationRoute =
                widget.navigationRoutes.where((r) => r.routeName == route).toList().firstOrNull;

            if (destinationRoute == null) {
              return null;
            }

            page = destinationRoute.page;

            title.value = destinationRoute.titleRoute;

            if (!_navigationRouteStack.contains(destinationRoute)) {
              _navigationRouteStack.add(destinationRoute);
            }

            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => page,
              transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                position: Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)).animate(animation),
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}
