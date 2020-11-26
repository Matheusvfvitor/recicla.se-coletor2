import 'dart:core';

import 'package:ansicolor/ansicolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'Navegador.dart';

AnsiPen yellowPen = AnsiPen()..yellow();
AnsiPen redPen = AnsiPen()..red();
AnsiPen greenPen = AnsiPen()..green();

class FirebaseDocuments {
  String users = "users";
  String user_activity = "user_activity";
  String trash_products = "trash_products";
  String sys_log = "sys_log";
  String programas = "programas";
  String pontos_coleta = "pontos_coleta";
  String points_trash_can = "points_trash_can";
  String picker_activity = "picker_activity";
  String picker = "picker";
  String link_app = "link_app";
  String custo_material = "custo_material";
  String coupons = "coupons";
  String coupons_kart = "coupons_kart";
  String cupons = "cupons";
  String coletas = "coletas";
  String trashcoins = "trashcoins";
  String agendamento = "agendamento";

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<DocumentSnapshot> usersDocSnp() async {
    print("FirebaseDocument auth: $auth");
    User usuarioLogado = firebaseAuth.currentUser;
    print("FirebaseDocument usuarioLogado : $usuarioLogado");
    String _idUsuarioLogado = usuarioLogado.uid.toString();
    print("FirebaseDocument idusuario : $_idUsuarioLogado");
    DocumentSnapshot snapshot =
        await db.collection(users).doc(_idUsuarioLogado).get();
    print("FirebaseDocument snapshot : $snapshot");
    return snapshot;
  }

//<<<<<<< HEAD >>>>>>
  Future<DocumentReference> userActivityDocRef() async {
    User usuarioLogado = firebaseAuth.currentUser;
    String _idUsuarioLogado = usuarioLogado.uid.toString();
    DocumentReference docref =
        await db.collection(user_activity).doc(_idUsuarioLogado);
    print("FirebaseDocument snapshot : $docref");
    return docref;
  }

  Future<QuerySnapshot> trashcoinsDoc() async {
    User usuarioLogado = firebaseAuth.currentUser;
    String _idUsuarioLogado = usuarioLogado.uid.toString();
    QuerySnapshot docref = await db
        .collection(user_activity)
        .doc(_idUsuarioLogado)
        .collection("trashcoins")
        .orderBy("date", descending: true)
        .get();

    return docref;
  }

  Future<QuerySnapshot> homeinfoDoc() async {
    User usuarioLogado = firebaseAuth.currentUser;
    String _idUsuarioLogado = usuarioLogado.uid.toString();
    QuerySnapshot docref = await db
        .collection(user_activity)
        .doc(_idUsuarioLogado)
        .collection("trashcans")
        .where("status", isEqualTo: 5)
        .where("trashid")
        .get();

    return docref;
  }

  Future<DocumentSnapshot> tcoinstotal() async {
    User usuarioLogado = firebaseAuth.currentUser;
    String _idUsuarioLogado = usuarioLogado.uid.toString();
    DocumentSnapshot docref =
        await db.collection(user_activity).doc(_idUsuarioLogado).get();

    return docref;
  }

  Future<QuerySnapshot> listProgram() async {
    var docRef = await db.collection("programas").get();
    return docRef;
  }

//=======
  Future<QuerySnapshot> locationQuerySnp() async {
    User usuarioLogado = firebaseAuth.currentUser;
    String _idUsuarioLogado = usuarioLogado.uid.toString();

    QuerySnapshot querySnapshot =
        await db.collection("$user_activity/$_idUsuarioLogado/my_places").get();
    return querySnapshot;
  }

  Future<void> addMyPlace(Map<String, dynamic> place) async {
    String placeId;
    User usuarioLogado = firebaseAuth.currentUser;
    String _currUser = usuarioLogado.uid.toString();

    CollectionReference my_places =
        db.collection('user_activity/$_currUser/my_places');
    my_places
        .add(place)
        .then((value) => {
              db
                  .doc('points_trash_can/$_currUser')
                  .update({'trashAddress': value.id}).whenComplete(
                      () => print(greenPen('Points trash can : $placeId'))),
              db
                  .collection('user_activity/$_currUser/my_places')
                  .doc(value.id)
                  .update({'id': value.id}).then((nvalue) => {})
            })
        .catchError((error) => {print("Erro ao cadastrar o local : $error")});

    Future.delayed(Duration(seconds: 2), () async {
      QuerySnapshot places =
          await db.collection('user_activity/$_currUser/my_places').get();

      if ((places.docs.length == null) || (places.docs.length == 1)) {
        print(greenPen(places.docs.length.toString()));

        places.docs.forEach((document) {
          placeId = document.data()['id'];
          print(redPen('objPlaces: $placeId'));
        });

        db
            .doc('user_activity/$_currUser')
            .update({'current_place': placeId}).whenComplete(
                () => print(greenPen(placeId)));
      }

      print(greenPen(placeId));
      print(yellowPen(places.docs.length.toString()));
      print(yellowPen(places.toString()));
    });
  }

  Future<void> removeMyPlace(String placeId) {
    User usuarioLogado = firebaseAuth.currentUser;
    String _currUser = usuarioLogado.uid.toString();
    print('place to delete: $placeId');
    print('path to delete: user_activity/$_currUser/my_places/$placeId');

    return db
        .collection('user_activity/$_currUser/my_places')
        .doc(placeId)
        .delete()
        .then((value) => print("Place Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateFavAddress(String placeId, bool favStatus) async {
    User usuarioLogado = firebaseAuth.currentUser;
    String _currUser = usuarioLogado.uid.toString();

    db
        .collection('user_activity')
        .doc(_currUser)
        .update({'current_place': placeId})
        .then((value) => print('current_place : Up-to-date'))
        .catchError((error) => print("Failed to update user: $error"));

    QuerySnapshot places =
        await db.collection('user_activity/$_currUser/my_places').get();
    places.docs.forEach((doc) {
      var placesObj = doc.data();
      bool fav = placesObj['fav'];

      if (placeId != doc.id && fav == true) {
        print('unfaving');
        db
            .doc('user_activity/$_currUser/my_places/${doc.id}')
            .update({'fav': false});
      }
    });
  }

  Future<void> updateFavStatus(String placeId, bool favStatus) {
    User usuarioLogado = firebaseAuth.currentUser;
    String _currUser = usuarioLogado.uid.toString();

    db
        .collection('user_activity/$_currUser/my_places')
        .doc(placeId)
        .update({'fav': favStatus})
        .then((value) => print('favStatus : Up-to-date'))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updatePlace(
      String placeId, String tag, String number, String comp) {
    User usuarioLogado = firebaseAuth.currentUser;
    String _currUser = usuarioLogado.uid.toString();

    db
        .collection('user_activity/$_currUser/my_places')
        .doc(placeId)
        .update({'tag': tag, 'number': number, 'comp': comp})
        .then((value) => print('Documento $placeId is Up-to-date'))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<QuerySnapshot> helpCardsIntro() {
    var docref = db.collection("help_info").get();
    return docref;
  }

  Future<QuerySnapshot> helpCardsDetails(String id) {
    var docref =
        db.collection("help_info").doc(id).collection("help_cards").get();
    return docref;
  }

  Future<QuerySnapshot> notificationCards() {
    var docref = db.collection("notification_info").get();
    return docref;
  }

  Future<QuerySnapshot> codShare() {
    var docref = db.collection("share_cod").get();
    return docref;
  }

  Future<DocumentSnapshot> pickerSelected(String id) {
    var docref = db.collection("picker").doc(id).get();
    return docref;
  }

  Future<DocumentSnapshot> primeiroLogin() {
    User usuarioLogado = firebaseAuth.currentUser;
    String _currUser = usuarioLogado.uid.toString();
    db.collection("picker").doc(_currUser).update({"primeiroLogin": "logado"});
  }

  Future<DocumentSnapshot> loginRoute(BuildContext context) {
    User usuarioLogado = firebaseAuth.currentUser;
    String _currUser = usuarioLogado.uid.toString();
    db.collection("picker").doc(_currUser).get().then((doc) {
      if (doc.data()["primeiroLogin"] == "" ||
          doc.data()["primeiroLogin"] == null) {
        Navegador().goToIntroScreen(context);
      } else {
        Navegador().goToHome(context);
      }
    });
  }

  Future<DocumentSnapshot> shareProgram() {
    User usuarioLogado = firebaseAuth.currentUser;
    String _currUser = usuarioLogado.uid.toString();
    var docref = db
        .collection("users")
        .doc(_currUser)
        .collection("share")
        .doc("programa")
        .get();
    return docref;
  }
}
