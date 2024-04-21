import 'package:flutter/material.dart';
import 'package:poc_navigator_2/constantes/app_routes.dart';
import 'package:poc_navigator_2/dialog_manager.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final controllerTeste = ControllerTeste();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POC Navigator 2.0',
      navigatorKey: navigatorKey,
      // builder: (context, widget) => DialogManager(
      //   NavigationFlow(
      //     appBarEnabled: false,
      //     initialRoute: AppRoutes.initialRoute,
      //     navigationRoutes: [
      //       NavigationRoute(routeName: AppRoutes.initialRoute, titlePage: 'Início', page: widget!),
      //       NavigationRoute(
      //         routeName: '/page2',
      //         titlePage: 'page2',
      //         page: Container(),
      //       ),
      //     ],
      //   ),
      // ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const HomePage(),
      routes: AppRoutes.routes,
    );
  }
}
