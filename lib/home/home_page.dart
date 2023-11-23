import 'package:flutter/material.dart';

import 'package:poc_navigator_2/conta/cadastro_page.dart';
import 'package:poc_navigator_2/conta/pagamento_page.dart';
import 'package:poc_navigator_2/conta/transferencia_page.dart';
import 'package:poc_navigator_2/widgets/navigationRoute.dart';
import 'package:poc_navigator_2/widgets/navigation_flow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => NavigationFlow(
                    initialRoute: '/cadastro',
                    navigationRoutes: [
                      NavigationRoute(routeName: '/cadastro', titleRoute: 'Conta corrente', page: const CadastroPage()),
                      NavigationRoute(
                          routeName: '/transferencia', titleRoute: 'Transferência', page: const TransferenciaPage()),
                      NavigationRoute(routeName: '/pagamento', titleRoute: 'Pagamento', page: const PagamentoPage()),
                    ],
                  ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                    position: Tween(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0)).animate(animation),
                    child: child,
                  )));
        },
        child: const Text('Ir para Conta corrente'),
      )),
    );
  }
}
