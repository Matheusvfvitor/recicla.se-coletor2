import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'FirebaseDocuments.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String currUser = auth.currentUser.uid;

class Users {
  String name;
  String uId;
  String email;
  String celular;
  String fotoPerfil;
  String primeiroLogin;
  String urifoto;

  Users(
      {this.name,
      this.uId,
      this.email,
      this.celular,
      this.fotoPerfil,
      this.primeiroLogin,
      this.urifoto});

  Future<Users> getuser() async {
    Users user = Users();

    DocumentSnapshot snapshot = await FirebaseDocuments().usersDocSnp();
    print("Users snapshot : ${snapshot.data()}");
    Map<String, dynamic> dados = snapshot.data();

    user.name = dados["name"];
    user.uId = dados["uId"];
    user.email = dados["email"];
    user.celular = dados["celular"];
    user.fotoPerfil = dados["fotoPerfil"];
    user.primeiroLogin = dados["primeiroLogin"];
    user.urifoto = dados["urifoto"];

    return user;
  }

  Future<void> getPrograma() async {
    var query = await FirebaseDocuments().shareProgram();
    return query;
  }

  Future<QuerySnapshot> getMyPlaces() async {
    QuerySnapshot query = await FirebaseDocuments().locationQuerySnp();
    return query;
  }

  Future<String> getImage() async {
    FirebaseStorage _storage =
        FirebaseStorage(storageBucket: "gs://trashapp-284420.appspot.com");

    Users user = await this.getuser();
    String urifoto = user.urifoto;

    if (urifoto != null && urifoto != "") {
      var url = await _storage
          .ref()
          .child("image_users/$currUser.png")
          .getDownloadURL();
      print("foto = $url");

      var fotoPerfil = url.toString();
      return fotoPerfil;
    }
  }
}
