import 'package:flutter/material.dart';
import 'package:poc_navigator_2/conta/cadastro_page.dart';
import 'package:poc_navigator_2/conta/pagamento_page.dart';
import 'package:poc_navigator_2/conta/transferencia_page.dart';
import 'package:poc_navigator_2/main.dart';
import 'package:poc_navigator_2/navigation_flow/domain/app_transitions.dart';
import 'package:poc_navigator_2/navigation_flow/domain/navigation_route.dart';
import 'package:poc_navigator_2/navigation_flow/ui/controllers/navigation_controller.dart';
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
          final controller = autoInector.tryGet<NavigationController>() ?? NavigationController();

          Navigator.of(context).push(
            SlideBottomToUp(
              page: NavigationFlow(
                controller: controller,
                initialRoute: '/cadastro',
                navigationRoutes: [
                  NavigationRoute(routeName: '/cadastro', titlePage: 'Conta corrente', page: const CadastroPage()),
                  NavigationRoute(
                    routeName: '/transferencia',
                    titlePage: 'Transferência',
                    page: const TransferenciaPage(),
                    // transitionType: AppTransitionType.CUSTOM_TRANSITION,
                    // transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                    //     FadeTransition(opacity: Tween<double>(begin: 0, end: 1).animate(animation), child: child),
                  ),
                  NavigationRoute(
                    routeName: '/pagamento',
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
      )),
    );
  }
}
