import 'package:flutter/material.dart';
import 'package:poc_navigator_2/constantes/app_routes.dart';
import 'package:poc_navigator_2/main.dart';
import 'package:poc_navigator_2/navigation_flow/domain/extensions/context_extensions.dart';
import 'package:poc_navigator_2/navigation_flow/ui/controllers/navigation_controller.dart';

class TransferenciaPage extends StatefulWidget {
  const TransferenciaPage({super.key});

  @override
  State<TransferenciaPage> createState() => _TransferenciaPageState();
}

class _TransferenciaPageState extends State<TransferenciaPage> {
  final controller = autoInector.get<NavigationController>();

  late String texto;

  @override
  Widget build(BuildContext context) {
    texto = AppRoutes.getArgs<String>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRoutes.pagamento, arguments: 'Boleto bancário');
              },
              child: Text('Ir para pagamento: $texto'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                controller.setTitlePage('NOVO TÍTULO');
              },
              child: const Text('Alterar título'),
            ),
          ],
        ),
      ),
    );
  }
}
