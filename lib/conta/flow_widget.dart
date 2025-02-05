import 'package:flutter/material.dart';
import 'package:poc_navigator_2/constantes/app_routes.dart';
import 'package:poc_navigator_2/conta/cadastro_page.dart';
import 'package:poc_navigator_2/conta/pagamento_page.dart';
import 'package:poc_navigator_2/conta/transferencia_page.dart';
import 'package:poc_navigator_2/navigation_flow/domain/navigation_route.dart';
import 'package:poc_navigator_2/navigation_flow/ui/widgets/navigation_flow.dart';

class FlowWidget extends StatefulWidget {
  const FlowWidget({super.key});

  @override
  State<FlowWidget> createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationFlow(
      initialRoute: AppRoutes.cadastro,
      navigationRoutes: [
        NavigationRoute(routeName: AppRoutes.cadastro, titlePage: 'Cadastro', page: const CadastroPage()),
        NavigationRoute(
          routeName: AppRoutes.transferencia,
          titlePage: 'Transferência',
          page: const TransferenciaPage(),
        ),
        NavigationRoute(
          routeName: AppRoutes.pagamento,
          titlePage: 'Pagamento',
          page: const PagamentoPage(),
        ),
      ],
    );
  }
}
