// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:poc_navigator_2/conta/cadastro_page.dart';
import 'package:poc_navigator_2/conta/transferencia_page.dart';
import 'package:poc_navigator_2/main.dart';
import 'package:poc_navigator_2/navigation_flow/domain/app_transitions.dart';
import 'package:poc_navigator_2/navigation_flow/domain/extensions/context_extensions.dart';
import 'package:poc_navigator_2/navigation_flow/domain/navigation_route.dart';
import 'package:poc_navigator_2/navigation_flow/ui/widgets/navigation_flow.dart';

import '../constantes/app_routes.dart';

class PagamentoPage extends StatefulWidget {
  const PagamentoPage({super.key});

  @override
  State<PagamentoPage> createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final texto = context.getArgs<String>() ?? NavigationFlow.currentRoute().titlePage;

      NavigationFlow.setTitlePage(texto);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                context.push(
                  rootNavigator: true,
                  SlideBottomToUp(
                    page: NavigationFlow(appBarEnabled: false, initialRoute: '/cadastro', navigationRoutes: [
                      NavigationRoute(
                          routeName: AppRoutes.cadastro, titlePage: 'Novo Cadastro', page: const CadastroPage()),
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
              child: const Text('Novo'),
            ),
            ElevatedButton(
              onPressed: () async {
                context.pop(rootNavigator: true);
              },
              child: const Text('Sair'),
            ),
            ElevatedButton(
              onPressed: () async {
                navigatorKey.currentState!.push(
                    MaterialPageRoute(builder: (context) => Scaffold(appBar: AppBar(), body: const PagamentoPage())));
              },
              child: const Text('Teste'),
            ),
            ElevatedButton(
              onPressed: () async {
                context.pushNamed(AppRoutes.pagamento);
              },
              child: const Text('Teste 2'),
            ),
          ],
        ),
      ),
    );
  }
}
