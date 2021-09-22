class Item{
  int? id;
   String? nome;
   num? quantidade;
   num? idLista_FK;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'quantidade': quantidade,
      'idLista_FK':idLista_FK
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    quantidade = map['quantidade'];
    idLista_FK = map['idLista_FK'];
  }

  Item({ this.nome,  this.quantidade,this.id,this.idLista_FK});
}