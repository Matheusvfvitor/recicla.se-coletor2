import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reciclase_coletor/Navegador.dart';

class ChangePerfilData {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void changeDataUser(String data, String update, BuildContext context) {
    final currUser = _firebaseAuth.currentUser;
    final userCollection = db.collection("users").doc(currUser.uid);
    userCollection.update({"$update": data}).then((_) {
      Navegador().goToPerfilPage(context);
      print("sucesso");
    }).catchError(() {
      print("Falha");
    });
  }

  void changeProgramUser(String data, String update, BuildContext context) {
    final currUser = _firebaseAuth.currentUser;
    print("user ${currUser.toString()}");
    print("var update  $update");

    db
        .collection("programas")
        .doc(data)
        .collection("participantes")
        .doc(currUser.uid)
        .set({"user": currUser.uid}).then((_) {
      // Navegador().goToPerfilPage(context);
      print("sucesso 1");
      db
          .collection("users")
          .doc(currUser.uid)
          .collection("share")
          .doc("programa")
          .set({"$update": data}).then((_) {
        Navegador().goToPerfilPage(context);
        print("sucesso 2");
      }).catchError(() {
        print("Falha");
      });
    }).catchError(() {
      print("Falha");
    });
  }
}
