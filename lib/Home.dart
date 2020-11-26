import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reciclase_coletor/LoginPage.dart';
import 'package:reciclase_coletor/TrashColors.dart';

import 'BottomBar.dart';
import 'FutureMap.dart';

FirebaseAuth auth = FirebaseAuth.instance;

String display;
List<String> result;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Widget _widget = FutureMap();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: TrashColors().appBarBackGround,
          title: Text("Olá, Coletor"),
          leading: IconButton(
            icon: Icon(Icons.logout),
            iconSize: 30,
            onPressed: () {
              auth.signOut();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.room,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {});
                }),
          ],
        ),
        body: Stack(
          children: [Container(child: _widget)],
        ),
        bottomSheet: BottomBar());
  }
}
