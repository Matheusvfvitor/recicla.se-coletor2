import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciclase_coletor/Navegador.dart';

class SiginUpPassEmail {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void siginUpNew(String nome, String email, String password,
      BuildContext context, BuildContext contextSnack, String codigo) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await _firebaseAuth.currentUser.sendEmailVerification().then((value) {
        print("email de verificacao enviado");
        final currUser = _firebaseAuth.currentUser;
        final userCollection = db.collection("picker");
        Map<String, dynamic> dados = {
          "celular": "",
          "email": email,
          "fotoPerfil": "",
          "name": nome,
          "primeiroLogin": "logado",
          "uid": currUser.uid.toString(),
          "urifoto": "",
          "carModel": "",
          "carPlate": "",
          "rate": 5,
        };

        userCollection.doc(currUser.uid.toString()).set(dados).then((value) {
          print("Usuario adicionado com sucesso");
          Scaffold.of(contextSnack).showSnackBar(
              SnackBar(content: Text("Usuario cadastrado com sucesso")));
          try {
            Navegador().goToPhoneValidation(context);
          } catch (error) {
            print("erro na tela : $error");
          }
        }).catchError((e) {
          print(e);
          Scaffold.of(contextSnack).showSnackBar(
              SnackBar(content: Text("Falha ao cadastrar usúario.")));
        });
        final ref = db.collection("user_activity");
        final share = db.collection("share_cod");
        final trashCans = db.collection("points_trash_can");
        final time = DateTime.now().millisecondsSinceEpoch;

        Map<String, dynamic> obj = {
          "name": currUser.uid,
          "current_place": "",
          "kg_met": 0,
          "kg_pap": 0,
          "kg_pl": 0,
          "kg_vid": 0,
          "n_item": 0,
          "ncoupon": 0,
          "ncoupons": 0,
          "nitem_met": 0,
          "nitem_pap": 0,
          "nitem_pl": 0,
          "nitem_vid": 0,
          "notification_token": "",
          "peso": 0,
          "tcoins": 3,
        };

        Map<String, dynamic> pointsTrashCans = {
          "id": currUser.uid,
          "kg_met": 0,
          "kg_pap": 0,
          "kg_pl": 0,
          "kg_vid": 0,
          "ncoupon": 0,
          "ncoupons": 0,
          "nitem_met": 0,
          "nitem_pap": 0,
          "nitem_pl": 0,
          "nitem_vid": 0,
          "tot_kg": 0,
          "tot_nitem": 0,
          "tot_tcoins": 3,
        };

        Map<String, dynamic> trashcoins = {
          "date": time,
          "value": 3,
          "full_desc": "",
          "category": "Crédito Reciclagem",
          "tipo": 1
        };

        if (codigo != null && codigo != "") {
          share
              .doc(codigo)
              .collection("shares")
              .doc(currUser.uid)
              .set({"id": currUser.uid, "date": time});
        }
        ref
            .doc(currUser.uid)
            .set(obj)
            .then((value) => print("adicionada ao users_activity"));

        ref
            .doc(currUser.uid)
            .collection("trashcoins")
            .doc(time.toString())
            .set(trashcoins)
            .then((value) => print("trashcoins adicionados"));

        trashCans
            .doc(currUser.uid)
            .set(pointsTrashCans)
            .then((value) => print("adicionada ao points_trash_can"))
            .catchError((e) {
          print("error $e");
        });
      });
    }).catchError((e) {
      print("e");
      return Scaffold.of(contextSnack)
          .showSnackBar(SnackBar(content: Text("Falha ao cadastrar usúario.")));
    });
  }
}
