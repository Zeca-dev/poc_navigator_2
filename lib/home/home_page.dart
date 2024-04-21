import 'package:flutter/material.dart';
import 'package:poc_navigator_2/constantes/app_routes.dart';
import 'package:poc_navigator_2/conta/cadastro_page.dart';
import 'package:poc_navigator_2/conta/pagamento_page.dart';
import 'package:poc_navigator_2/conta/transferencia_page.dart';
import 'package:poc_navigator_2/navigation_flow/domain/app_transitions.dart';
import 'package:poc_navigator_2/navigation_flow/domain/extensions/context_extensions.dart';
import 'package:poc_navigator_2/navigation_flow/domain/navigation_route.dart';
import 'package:poc_navigator_2/navigation_flow/ui/widgets/navigation_flow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push(
              SlideBottomToUp(
                page: NavigationFlow(
                  initialRoute: AppRoutes.cadastro,
                  navigationRoutes: [
                    NavigationRoute(routeName: AppRoutes.cadastro, titlePage: 'Cadastro', page: const CadastroPage()),
                    NavigationRoute(
                      routeName: AppRoutes.transferencia,
                      titlePage: 'Transferência',
                      page: const TransferenciaPage(),
                      // transitionType: AppTransitionType.CUSTOM_TRANSITION,
                      // transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                      //     FadeTransition(opacity: Tween<double>(begin: 0, end: 1).animate(animation), child: child),
                    ),
                    NavigationRoute(
                      routeName: AppRoutes.pagamento,
                      titlePage: 'Pagamento',
                      page: const PagamentoPage(),
                      // transitionType: AppTransitionType.SLIDE_LEFT_TO_RIGHT,
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Text('Ir para Conta corrente'),
        ),
      ),
    );
  }
}
