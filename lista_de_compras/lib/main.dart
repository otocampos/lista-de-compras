import 'package:flutter/material.dart';
import 'package:lista_de_compras/paginas/tela-principal.dart';
import 'package:lista_de_compras/paginas/tela_config.dart';
import 'package:lista_de_compras/paginas/tela_criar_lista.dart';
import 'package:lista_de_compras/theme/theme_app_dark.dart';

import 'constantes/constantesRotas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      debugShowCheckedModeBanner: false,
      initialRoute: Rota.rotaListasdeCompras,
      routes: {
        Rota.rotaInicial: (context) => telaPrincipal(),
        Rota.rotaConfigs: (context) => telaConfig(),
        Rota.rotaListasdeCompras: (context) => telaCriarLista()

      },
    );
  }

}
