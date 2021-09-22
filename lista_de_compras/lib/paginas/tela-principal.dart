import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_compras/constantes/constantesRotas.dart';
import 'package:lista_de_compras/helpers/database_helper.dart';
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
  Color? corCard;
  DatabaseHelper dataBaseHelper = DatabaseHelper();

  Future<List<Item>> fetchAllItensById(int id) async {
    return dataBaseHelper.getAllItensFromList(id);
  }

  @override
  void initState() {
    Ccor();
  }

  @override
  Widget build(BuildContext context) {
    var idListaDeCompras = ModalRoute.of(context)?.settings.arguments as int;
    print(idListaDeCompras);
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
                      onPressed: () {},
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
        Expanded(
          child: FutureBuilder<List<Item>>(
            future: fetchAllItensById(idListaDeCompras),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List<Item>? itensList = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
                        child: Card(
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
                                onTap: (){
                                  print('click');
                                  Navigator.pushNamed(context, Rota.rotaInicial,arguments:itensList?[index].id );
                                },
                                leading: Text('${index + 1}'),
                                title: Text('${itensList?[index].nome}'))),
                      );
                    });
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new Container(
                alignment: AlignmentDirectional.center,
                child: new CircularProgressIndicator(),
              );
            },
          ),),
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
                  onPressed: () async {
                    setState(() {
                      var item = Item(
                          idLista_FK: idListaDeCompras,
                          nome: edtTxtItemController.text,
                          quantidade: int.parse(edtTxtQntController.text));
                      dataBaseHelper.insertCriarItens(item).then((value) => print(value.nome));
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
