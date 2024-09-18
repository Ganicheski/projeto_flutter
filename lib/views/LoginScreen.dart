import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Bem-vindo a Tela Inicial',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ])),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text('XXX'),
                accountEmail: Text('Gabriel@gmail.com')),
            ListTile(
              leading: Icon(Icons.task_alt_sharp),
              title: Text('Sair'),
            )
          ],
        ),
      ),
    );
  }
}
