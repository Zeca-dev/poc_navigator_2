import 'package:flutter/material.dart';
import 'package:poc_navigator_2/main.dart';
import 'package:poc_navigator_2/navigator_flow/ui/controllers/navigation_controller.dart';

class TransferenciaPage extends StatefulWidget {
  const TransferenciaPage({super.key});

  @override
  State<TransferenciaPage> createState() => _TransferenciaPageState();
}

class _TransferenciaPageState extends State<TransferenciaPage> {
  final controller = autoInector.get<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/pagamento');
              },
              child: const Text('Ir para pagamento'),
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
