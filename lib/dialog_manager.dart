import 'package:flutter/material.dart';

import 'conta/pagamento_page.dart';
import 'main.dart';

class DialogManager extends StatefulWidget {
  const DialogManager(this.child, {super.key});

  final Widget child;

  @override
  State<DialogManager> createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ControllerTeste {
  void push() {
    navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (context) => Scaffold(appBar: AppBar(), body: const PagamentoPage())));
  }

  void pushNamed(String routeName) {
    navigatorKey.currentState!.pushNamed(routeName);
  }
}
