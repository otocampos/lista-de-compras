import 'package:flutter/material.dart';
import 'package:lista_de_compras/constantes/constantesRotas.dart';
import 'package:lista_de_compras/helpers/database_helper.dart';
import 'package:lista_de_compras/models/lista.dart';
import 'package:sqflite/sqflite.dart';

class telaCriarLista extends StatefulWidget {
  @override
  _telaCriarListaState createState() => _telaCriarListaState();
}

class _telaCriarListaState extends State<telaCriarLista> {
  DatabaseHelper dataBaseHelper = DatabaseHelper();
  List<Lista> lista = [];
  TextEditingController _textFieldController = TextEditingController();

  Future<List<Lista>> fetchAllListasDeCompras() async {
    return dataBaseHelper.getAllLista();
  }

  @override
  void initState() {
    super.initState();

    dataBaseHelper.getAllLista().then((value) {
      lista = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas de Compras'),
      ),
      body: FutureBuilder<List<Lista>>(
        future: fetchAllListasDeCompras(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  List<Lista>? itensList = snapshot.data;
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Nova Lista de Compras'),
              content: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "Título da lista de compras"),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: ()async  {
                    await dataBaseHelper.insertCriarListaDeCompras(Lista(nome:_textFieldController.text));
                    setState(() {

                    });
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }


}
