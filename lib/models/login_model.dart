class Login {
  String? email;
  String? senha;
  String? nome;

  Login({this.email, this.senha, this.nome});

  Map toJson() {
    return {'email': email, 'senha': senha, 'nome': nome};
  }

  Login.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    senha = json['senha'];
    nome = json['nome'];
  }
}
