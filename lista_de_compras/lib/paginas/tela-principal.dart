import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_compras/models/Item.dart';

class telaPrincipal extends StatefulWidget {
  @override
  _telaPrincipalState createState() => _telaPrincipalState();
}

class _telaPrincipalState extends State<telaPrincipal> {
  var lista = <Item>[];
  final edtTxtItemController = TextEditingController();
  final edtTxtQntController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
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
                            elevation: 8.0,
                            child: ListTile(
                              trailing:IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                  lista.removeAt(index);
                                  });
                                },
                              ) ,
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
                padding: const EdgeInsets.only(bottom: 16.0,right: 16),
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.save),
                  onPressed: () {
                    setState(() {
                      var item = Item(nome: edtTxtItemController.text, quantidade:int.parse(edtTxtQntController.text));
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
}
