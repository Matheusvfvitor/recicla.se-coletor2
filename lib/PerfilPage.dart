import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Navegador.dart';
import 'TrashColors.dart';
import 'dataPerfilUser.dart';
import 'dataProgramaUser.dart';
import 'dataPhotoUser.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TrashColors().appBarBackGround,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navegador().goToHome(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[],
        title: Text("Informações do Perfil"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      DataPhotoUser(),
                      Container(
                        margin: EdgeInsets.only(top: 90, bottom: 20, left: 60),
                        child: FloatingActionButton(
                          child: Icon(Icons.camera_alt),
                          onPressed: () {
                            Navegador().goToPerfilChgPhoto(context);
                          },
                          backgroundColor: TrashColors().buttonColor,
                        ),
                      )
                    ]),
                    Divider(
                      height: 0,
                    ),
                  ],
                ),
              ),
            ),
            DataPerilUser(),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: Divider(
                height: 0,
              ),
            ),
            DataProgramaUser(),
          ],
        ),
      ),
    );
  }
}
