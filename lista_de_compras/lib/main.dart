
import 'package:flutter/material.dart';
import 'package:lista_de_compras/paginas/tela-principal.dart';

import 'constantes/constantesRotas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Rota.rotaInicial,
      routes: {
        Rota.rotaInicial: (context) =>  telaPrincipal(),
      },
    );
  }
}