import 'package:flutter/material.dart';
import 'package:poc_navigator_2/constantes/app_routes.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  @override
  Widget build(BuildContext context) {
    final texto = AppRoutes.getArgs<String>(context);
    print(texto);
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.transferencia, arguments: 'Argumento passado');
        },
        child: const Text('Ir para transferência'),
      )),
    );
  }
}
