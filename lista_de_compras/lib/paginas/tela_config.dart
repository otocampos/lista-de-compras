import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/constantes/constantesRotas.dart';
import 'package:lista_de_compras/theme/theme_app_dark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class telaConfig extends StatefulWidget {
  @override
  _telaConfigState createState() => _telaConfigState();
}


class _telaConfigState extends State<telaConfig> {
  @override
  initState()  {
    getPrefs();
    // TODO: implement initState

  }
  var lista =<String>['vermelho','preto','amarelo'];
  var listaCor= Rota.mapColors;
   String? teste;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25),
            Text(
              "Color Theme",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Cor dos Cards')],
              ),
            ),
            RadioListTile<String>(
              title: const Text('Vermelho'),
              value:listaCor.keys.first ,
              groupValue: teste,
              onChanged: (String? value) {
                setState(() {
                  teste = value!;
                });
              },
            ),
          RadioListTile<String>(
            title: const Text('Preto'),
            value: listaCor.entries.toList()[1].key,
            groupValue: teste,
            onChanged: (String? value) {
              setState(() {
                teste = value!;
              });
            },
          ),RadioListTile<String>(
        title: const Text('Amarelo'),
        value: listaCor.keys.last,
        groupValue: teste,
        onChanged: (String? value) {
          setState(() {
            teste = value!;
          });
        },
      ),
            ElevatedButton(
              onPressed: () async{
                preferencias(teste);
                print(teste);
              },
              child: Text('salvar'),
            )
          ],
        ),
      ),
    );
  }

  void preferencias(cor) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('corCards', cor).then((value) =>
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Rota.rotaInicial, (Route<dynamic> route) => false)   );
  }
void getPrefs() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var cor = prefs.getString('corCards') ?? listaCor.keys.first;
  print(cor);
  setState(() {
    teste = cor;
  });
}

}
