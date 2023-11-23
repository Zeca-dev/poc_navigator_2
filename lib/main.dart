import 'package:flutter/material.dart';
import 'package:poc_navigator_2/constantes/routes.dart';
import 'package:poc_navigator_2/conta/conta_page.dart';
import 'package:poc_navigator_2/home/home_page.dart';

void main() {
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
      routes: {
        Routes.home: (_) => const HomePage(),
        Routes.conta: (_) => const ContaPage(),
      },
    );
  }
}
