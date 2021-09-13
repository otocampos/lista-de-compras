import 'dart:io';

import 'package:lista_de_compras/constantes/constantesTabelas.dart';
import 'package:lista_de_compras/constantes/constantesTabelas.dart';
import 'package:lista_de_compras/models/Item.dart';
import 'package:lista_de_compras/models/lista.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }
  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}listadecompras.db';

    var listaDatabase =
    await openDatabase(path, version: 1, onCreate: _createDB);
    return listaDatabase;
  }
  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS ${constantesTabelas.TABLE_LISTA_DE_COMPRAS} (${constantesTabelas.COL_ID_LISTA_DE_COMPRAS} integer primary key autoincrement,'
            ' ${constantesTabelas.COL_QNT_ITENS_LISTA_DE_COMPRAS} integer not null,'
            ' ${constantesTabelas.COL_NOME_LISTA_DE_COMPRAS} text not null)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS ${constantesTabelas.TABLE_ITENS_COMPRAS} (${constantesTabelas.COL_ID_ITEM} integer primary key autoincrement,'
            ' ${constantesTabelas.COL_NOME_ITEM} text not null,'
            ' ${constantesTabelas.COL_ID_LISTA_PAI} integer not null,'
            '${constantesTabelas.COL_QNT_ITENS_LISTA_DE_COMPRAS} integer not null,'
    'FOREIGN KEY(${constantesTabelas.COL_ID_LISTA_PAI}) REFERENCES ${constantesTabelas.TABLE_LISTA_DE_COMPRAS}(${constantesTabelas.COL_ID_LISTA_DE_COMPRAS}))');

  }

  Future<Lista>insertCriarListaDeCompras(Lista lista) async {
    Database? db = await this.database;
    lista.id = await db!.insert(constantesTabelas.TABLE_LISTA_DE_COMPRAS,lista.toMap());
    return lista;
  }

  Future<List<Lista>>getAllLista(Lista lista) async {
    Database? db = await this.database;

    var resultado = await db!.query(constantesTabelas.TABLE_LISTA_DE_COMPRAS);
    List<Lista> lista = resultado.isNotEmpty
        ? resultado.map((e) => Lista.fromMap(e)).toList()
        : [];
    return lista;
  }

   insertCriarItens(List<Item> itens,int idLista) async {
    Database? db = await this.database;
   itens.forEach((element) async{
       await db!.insert(constantesTabelas.TABLE_LISTA_DE_COMPRAS,element.toMap()).then((value) => print(value));
    });
  }



  Future close() async {
    Database? db = await this.database;
    db!.close();
  }
}