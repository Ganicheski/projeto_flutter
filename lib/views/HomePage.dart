import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/services/authentication_service.dart';
import 'package:projeto/services/firestore_service.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Filmes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List tasksList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = tasksList[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String taskTitle = data["title"];
                String taskDescription = data["description"];
                String taskGenero = data["genero"];
                String taskDate = data["date"];
                String taskNota = data["nota"];
                String docId = document.id;
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      tileColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      title: Text(
                        taskTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21.0,
                            fontStyle: FontStyle.italic),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          Text("Gênero: $taskGenero"),
                          SizedBox(height: 8.0),
                          Text("Data Assistida: $taskDate"),
                          SizedBox(height: 8.0),
                          Text("Descrição: $taskDescription"),
                        ],
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Nota: $taskNota",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _openModalForm(context, firestoreService,
                                        docId: docId);
                                  },
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.grey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    firestoreService.deleteTask(docId);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.displayName != null
                  ? widget.user.displayName!
                  : "Não Informado"),
              accountEmail: Text(widget.user.email != null
                  ? widget.user.email!
                  : "Não informado"),
            ),
            ListTile(
              title: Text('Sair'),
              leading: Icon(Icons.logout),
              onTap: () {
                AuthenticationService().logoutUser();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openModalForm(context, firestoreService);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _openModalForm(BuildContext context, FirestoreService firestoreService,
      {String? docId}) async {
    final _titleController = TextEditingController();
    final _descriptionController = TextEditingController();
    String? _genero;
    String? _taskDate;
    final _taskDateController = TextEditingController();
    final _notaController = TextEditingController();

    if (docId != null) {
      DocumentSnapshot document = await firestoreService.getTask(docId);
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      _titleController.text = data["title"];
      _descriptionController.text = data["description"];
      _genero = data["genero"];
      _taskDateController.text = _taskDate ?? '';
      _notaController.text = data["nota"];
    }

    Future<void> _selectDate() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate:
            _taskDate != null ? DateTime.parse(_taskDate!) : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        setState(() {
          _taskDate = "${pickedDate.day.toString().padLeft(2, '0')}/"
              "${pickedDate.month.toString().padLeft(2, '0')}/"
              "${pickedDate.year}";
        });
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 99, 131, 151),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            docId == null ? "Adicionar Filme" : "Editar Filme",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(color: Colors.white),
                SizedBox(height: 10),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Título",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _genero,
                  decoration: InputDecoration(
                    labelText: 'Gênero',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.movie),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _genero = newValue;
                    });
                  },
                  items: <String>[
                    'Ação',
                    'Aventura',
                    'Comédia',
                    'Documentário',
                    'Drama',
                    'Ficção científica',
                    'Romance',
                    'Terror',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _taskDateController,
                  decoration: InputDecoration(
                    labelText: "Data",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  readOnly: true,
                  onTap: _selectDate,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _notaController,
                  decoration: InputDecoration(
                    labelText: "Nota",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.star),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final decimalValue = double.tryParse(value) ?? 0.0;
                      _notaController.text = decimalValue.toStringAsFixed(1);
                      _notaController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _notaController.text.length));
                    }
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Título é obrigatório!')),
                      );
                      return;
                    }
                    if (_descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Descrição é obrigatória!')),
                      );
                      return;
                    }
                    if (_genero == null || _genero!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gênero é obrigatório!')),
                      );
                      return;
                    }
                    if (_taskDate == null || _taskDate!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Data é obrigatória!')),
                      );
                      return;
                    }

                    if (docId == null) {
                      firestoreService.addTask(
                        _titleController.text,
                        _descriptionController.text,
                        _genero,
                        _taskDate,
                        _notaController.text,
                      );
                    } else {
                      firestoreService.updateTask(
                        docId,
                        _titleController.text,
                        _descriptionController.text,
                        _genero,
                        _taskDate,
                        _notaController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Alterado com sucesso!'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    }

                    _titleController.clear();
                    _taskDateController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
