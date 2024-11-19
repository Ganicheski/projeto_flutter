import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  registerUser(
      {required String email,
      required String senha,
      required String nome}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha);
      await credential.user!.updateDisplayName(nome);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email já cadastrado!';
      }
    }
  }

  loginUser({required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Usuário não encontrado!';
      } else if (e.code == 'wrong-password') {
        return 'Senha incorreta!';
      }
      return e.message;
    }
  }

  logoutUser() {
    return _firebaseAuth.signOut();
  }
}
