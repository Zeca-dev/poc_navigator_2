import 'package:flutter/material.dart';

class NavigationFlow extends StatefulWidget {
  const NavigationFlow({
    super.key,
    required this.title,
    required this.initialRoute,
    required this.routes,
  });

  final String initialRoute;

  final Map<String, Widget> routes;

  final String title;

  @override
  State<NavigationFlow> createState() => _NavigationFlowState();
}

class _NavigationFlowState extends State<NavigationFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final controllerTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerTitle.text = widget.title;
  }

  @override
  void dispose() {
    super.dispose();
    controllerTitle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () => _navigatorKey.currentState!.pop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(controllerTitle.text),
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

            Widget? destinationPage = widget.routes[route];

            if (destinationPage == null) {
              return null;
            }

            page = destinationPage;
            //TODO: VER UMA FORMA DE DAR SETSTATE AQUI DENTRO
            controllerTitle.text = 'Novo título';

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
