import 'package:flutter/material.dart';
import 'package:poc_navigator_2/constantes/app_routes.dart';
import 'package:poc_navigator_2/navigation_flow/domain/extensions/context_extensions.dart';
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
      final texto = AppRoutes.getArgs<String>(context);
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
        },
        child: const Text('Sair'),
      )),
    );
  }
}
