import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/views/HomePage.dart';
import 'package:projeto/views/LoginRegister.dart';
import 'package:projeto/models/login_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto/views/LoginScreen.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

String? requiredValidator(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira $fieldName';
  }
  return null;
}

class MyApp extends StatelessWidget {
  final Login? login;
  final int? index;
  const MyApp({super.key, this.login, this.index});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: false,
      ),
      home: const MyWidget(),
      routes: {
        '/registrarUsuario': (context) => LoginRegister(),
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage(user: snapshot.data!);
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
