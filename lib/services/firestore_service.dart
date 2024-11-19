import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection("tasks");

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  Future addTask(String title, String description, String? genero, String? date,
      String nota) {
    return tasks.add({
      "title": title,
      "description": description,
      "userId": userId,
      "genero": genero,
      "date": date,
      "nota": nota,
    });
  }

  Stream<QuerySnapshot> getTasksStream() {
    return tasks.where('userId', isEqualTo: userId).snapshots();
  }

  Future<void> updateTask(String docId, String newTitle, String newDescription,
      String? genero, String? date, String newNota) {
    return tasks.doc(docId).update({
      "title": newTitle,
      "description": newDescription,
      "genero": genero,
      "date": date,
      "nota": newNota
    });
  }

  Future<void> deleteTask(String docId) {
    return tasks.doc(docId).delete();
  }

  Future<DocumentSnapshot> getTask(String docId) {
    return tasks.doc(docId).get();
  }
}
