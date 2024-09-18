class Login {
  String? email;
  String? senha;

  Login({this.email, this.senha});

  Map toJson() {
    return {'email': email, 'senha': senha};
  }

  Login.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    senha = json['senha'];
  }
}
