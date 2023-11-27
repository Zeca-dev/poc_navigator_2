import 'package:flutter/material.dart';
import 'package:poc_navigator_2/constantes/app_routes.dart';
import 'package:poc_navigator_2/conta/cadastro_page.dart';
import 'package:poc_navigator_2/conta/transferencia_page.dart';
import 'package:poc_navigator_2/navigation_flow/domain/app_transitions.dart';
import 'package:poc_navigator_2/navigation_flow/domain/extensions/context_extensions.dart';
import 'package:poc_navigator_2/navigation_flow/domain/navigation_route.dart';
import 'package:poc_navigator_2/navigation_flow/ui/widgets/navigation_flow.dart';

class PagamentoPage extends StatefulWidget {
  const PagamentoPage({super.key});

  @override
  State<PagamentoPage> createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final texto = context.getArgs<String>() ?? '';
      NavigationFlow.controller.setTitlePage('Pagamento de $texto');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          context.pop(rootNavigator: true);
          context.push(
            SlideBottomToUp(
              page: NavigationFlow(initialRoute: '/cadastro', navigationRoutes: [
                NavigationRoute(routeName: AppRoutes.cadastro, titlePage: 'Novo Cadastro', page: const CadastroPage()),
                NavigationRoute(
                    routeName: AppRoutes.transferencia,
                    titlePage: 'Nova Transferência',
                    page: const TransferenciaPage()),
                NavigationRoute(
                    routeName: AppRoutes.pagamento, titlePage: 'Novo Pagamento', page: const PagamentoPage()),
              ]),
            ),
          );
        },
        child: const Text('Sair'),
      )),
    );
  }
}
