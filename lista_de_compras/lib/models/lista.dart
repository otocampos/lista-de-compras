class Lista{
  int? id;
  String? nome;
  Lista({ this.nome, this.id});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
    'nome': nome,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
  Lista.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }



}