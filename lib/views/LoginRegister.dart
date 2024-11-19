import 'package:flutter/material.dart';
import 'package:projeto/models/login_model.dart';
import 'package:projeto/services/authentication_service.dart';
import 'package:projeto/services/dialog_widget.dart';

class LoginRegister extends StatefulWidget {
  final Login? login;
  final int? index;
  const LoginRegister({super.key, this.login, this.index});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

String? requiredValidator(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira $fieldName';
  }
  return null;
}

class _LoginRegisterState extends State<LoginRegister> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  AuthenticationService _authService = AuthenticationService();
  bool _hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 95.0,
                height: 95.0,
                child: Image.asset('assets/dd2.png')),
            const Text(
              'Cadastro',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _nomeController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) =>
                          requiredValidator(value, "seu nome"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) =>
                          requiredValidator(value, "um email"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                        controller: _senhaController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _hide,
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hide ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _hide = !_hide;
                              });
                            },
                          ),
                        ),
                        validator: (value) =>
                            requiredValidator(value, "uma senha")),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          String nome = _nomeController.text;
                          String email = _emailController.text;
                          String senha = _senhaController.text;
                          _authService
                              .registerUser(
                                  nome: nome, email: email, senha: senha)
                              .then((value) {
                            if (value != null) {
                              dialogWidget(
                                  context: context,
                                  title: value,
                                  isError: true);
                            } else {
                              dialogWidget(
                                  context: context,
                                  title: 'Cadastro Efetuado com sucesso!',
                                  isError: false);
                              Navigator.pop(context);
                            }
                          });
                        }
                      },
                      child: Text('Cadastrar')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
