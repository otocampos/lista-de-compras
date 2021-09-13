import 'package:flutter/material.dart';
import 'package:lista_de_compras/helpers/database_helper.dart';
import 'package:lista_de_compras/models/lista.dart';
import 'package:sqflite/sqflite.dart';

class telaCriarLista extends StatefulWidget {
  @override
  _telaCriarListaState createState() => _telaCriarListaState();
}

class _telaCriarListaState extends State<telaCriarLista> {
  TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas de Compras'),
      ),
      body: Center(child: Column(children: [



      ],),),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(

            title: const Text('AlertDialog Title'),
            content: TextField(
              onChanged: (value) {
        setState(() {
        });
        },
          controller: _textFieldController,
          decoration: InputDecoration(hintText: "Text Field in Dialog"),
        ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
salvarListaDeCompras(_textFieldController.text);
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
  salvarListaDeCompras(String nome)async{
    DatabaseHelper dataBaseHelper = DatabaseHelper();
    Lista lista = Lista(nome:nome);
    dataBaseHelper.insertCriarListaDeCompras(lista);



  }
}
