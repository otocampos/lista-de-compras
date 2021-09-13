class Item{
  int? id;
   String? nome;
   num? quantidade;
   num? idLista_FK;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'idLista_FK':idLista_FK
    };
    return map;
  }

  Item({ this.nome,  this.quantidade,this.id,this.idLista_FK});
}