import 'package:flutter/material.dart';

dialogWidget({context, required String title, required bool isError}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(isError ? 'Erro' : 'Sucesso'),
        content: Text(title),
        actions: <Widget>[
          TextButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
