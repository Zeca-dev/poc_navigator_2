import 'package:flutter/material.dart';
import 'package:poc_navigator_2/conta/cadastro_page.dart';
import 'package:poc_navigator_2/conta/flow_widget.dart';
import 'package:poc_navigator_2/conta/pagamento_page.dart';
import 'package:poc_navigator_2/conta/transferencia_page.dart';
import 'package:poc_navigator_2/home/home_page.dart';

final class AppRoutes {
  AppRoutes._();

  ///Map de Rotas nomeadas
  static final Map<String, WidgetBuilder> routes = {
    initialRoute: (_) => const HomePage(),
    cadastro: (_) => const CadastroPage(),
    transferencia: (_) => const TransferenciaPage(),
    pagamento: (_) => const PagamentoPage(),
    flow: (_) => const FlowWidget(),
  };

  //Nomes das rotas
  static const initialRoute = '/';
  static const cadastro = '/cadastro';
  static const transferencia = '/transferencia';
  static const pagamento = '/pagamento';
  static const text = '/text';
  static const flow = '/flow';
}
