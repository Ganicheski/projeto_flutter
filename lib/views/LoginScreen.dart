import 'package:flutter/material.dart';
import 'package:projeto/models/login_model.dart';
import 'package:projeto/services/authentication_service.dart';
import 'package:projeto/services/dialog_widget.dart';

class LoginScreen extends StatefulWidget {
  final Login? login;
  final int? index;
  const LoginScreen({super.key, this.login, this.index});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String? requiredValidator(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira $fieldName';
  }
  return null;
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  AuthenticationService _authService = AuthenticationService();
  bool _hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 150.0,
                height: 150.0,
                child: Image.asset('assets/smile.png')),
            const Text(
              'Login',
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
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      validator: (value) =>
                          requiredValidator(value, "seu email"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _senhaController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _hide,
                      decoration: InputDecoration(
                        labelText: 'Senha',
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
                          requiredValidator(value, "sua senha"),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          String email = _emailController.text;
                          String senha = _senhaController.text;
                          _authService
                              .loginUser(email: email, senha: senha)
                              .then((erro) {
                            if (erro != null) {
                              dialogWidget(
                                  context: context, title: erro, isError: true);
                            }
                          });
                          Navigator.pushNamed(context, '/home');
                          print('Validou os campos');
                        }
                      },
                      child: Text('Entrar')),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registrarUsuario');
                    },
                    child: Text('Ainda não tem uma conta? Registre-se agora!'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
