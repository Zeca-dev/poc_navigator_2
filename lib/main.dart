import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:poc_navigator_2/constantes/app_routes.dart';

import 'navigation_flow/ui/controllers/navigation_controller.dart';

final autoInector = AutoInjector();

void main() {
  autoInector.addInstance('');
  autoInector.addLazySingleton<NavigationController>(NavigationController.new);
  autoInector.commit();

  usePathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POC Navigator 2.0',
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
