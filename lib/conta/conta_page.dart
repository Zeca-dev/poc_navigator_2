import 'package:flutter/material.dart';
import 'package:poc_navigator_2/constantes/routes.dart';
import 'package:poc_navigator_2/conta/cadastro_page.dart';
import 'package:poc_navigator_2/conta/pagamento_page.dart';
import 'package:poc_navigator_2/conta/transferencia_page.dart';

class ContaPage extends StatefulWidget {
  const ContaPage({super.key});

  @override
  State<ContaPage> createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        if (canPop) {
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conta'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close))
          ],
        ),
        body: Navigator(
          key: navigatorKey,
          initialRoute: Routes.cadastro,
          onGenerateRoute: (settings) {
            var route = settings.name;
            Widget page;
            switch (route) {
              case Routes.cadastro:
                page = const CadastroPage();
                break;
              case Routes.transferencia:
                page = const TransferenciaPage();
                break;
              case Routes.pagamento:
                page = const PagamentoPage();
                break;
              default:
                return null;
            }
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => page,
                fullscreenDialog: true,
                transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                      position: Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)).animate(animation),
                      child: child,
                    ));

            return MaterialPageRoute(builder: (context) => page, settings: settings);
          },
        ),
      ),
    );
  }
}
