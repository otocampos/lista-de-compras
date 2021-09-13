import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_compras/constantes/constantesRotas.dart';
import 'package:lista_de_compras/models/Item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class telaPrincipal extends StatefulWidget {
  @override
  _telaPrincipalState createState() => _telaPrincipalState();
}

class _telaPrincipalState extends State<telaPrincipal> {
  var lista = <Item>[];
  final edtTxtItemController = TextEditingController();
  final edtTxtQntController = TextEditingController();
  Color? corCard ;

  @override
  void initState() {
    Ccor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Colors.white,
            tooltip: "Save all",
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[

                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {

                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            tooltip: "config",
            onPressed: () {
              Navigator.pushNamed(context, Rota.rotaConfigs);
            },
          ),
        ],
      ),
      body: Center(
          child: Column(children: <Widget>[
        SizedBox(height: 18),
        lista.length > 0
            ? Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: lista.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 32, right: 32, top: 8),
                        child: Card(
                            color: corCard,
                            elevation: 8.0,
                            child: ListTile(
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      lista.removeAt(index);
                                    });
                                  },
                                ),
                                leading: Text('${index + 1}'),
                                subtitle: Text('${lista[index].quantidade} Kg'),
                                title: Text('${lista[index].nome}'))),
                      );
                    }))
            : Expanded(child: Center(child: Text('Lista está vaia'))),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 20,
                  controller: edtTxtItemController,
                  decoration: InputDecoration(
                    hintText: "O que comprar?",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: edtTxtQntController,
                    decoration: InputDecoration(
                      //focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)) ,
                      hintText: 'kg',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, right: 16),
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      var item = Item(
                          nome: edtTxtItemController.text,
                          quantidade: int.parse(edtTxtQntController.text));
                      lista.add(item);
                      edtTxtItemController.clear();
                      edtTxtQntController.clear();
                    });
                  },
                ),
              )
            ],
          ),
        )
      ])),
    );
  }

  void Ccor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cor = prefs.getString('corCards') ?? false;
    print(cor);
    setState(() {
      Color? teste = Rota.mapColors[cor];
      corCard = teste ?? Colors.white;
    });
  }
}
