import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'FirebaseDocuments.dart';
import 'Navegador.dart';
import 'SizeConfig.dart';
import 'TrashColors.dart';
import 'Users.dart';

class DataProgramaUser extends StatefulWidget {
  @override
  _DataProgramaUserState createState() => _DataProgramaUserState();
}

class _DataProgramaUserState extends State<DataProgramaUser> {
  Users user = Users();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseDocuments().shareProgram(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 32),
                        child: Shimmer.fromColors(
                            child: SizedBox(
                              width: 100,
                              height: 20,
                            ),
                            direction: ShimmerDirection.ltr,
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[700]),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 32),
                        child: Shimmer.fromColors(
                            child: SizedBox(
                              width: 100,
                              height: 20,
                            ),
                            direction: ShimmerDirection.ltr,
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[700]),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 32),
                        child: Shimmer.fromColors(
                            child: SizedBox(
                              width: 100,
                              height: 20,
                            ),
                            direction: ShimmerDirection.ltr,
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[700]),
                      ),
                    ]));
          } else if (snapshot.hasData) {
            print("NomeUser snapshot ${snapshot.data.data()}");
            var programa;
            if (snapshot.data.data() == null) {
              programa = "Não participa";
            } else {
              var obj = snapshot.data.data();
              programa = obj["programa"];
            }

            return Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text("Programa",
                              style: TextStyle(
                                  fontSize: SizeConfig.of(context)
                                      .dynamicScale(size: 20),
                                  color: Colors.grey[400]))),
                      Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.apps),
                                    Text(" "),
                                    GestureDetector(
                                        onTap: () {
                                          Navegador().goToPerfilChgPrograma(
                                              context, programa);
                                        },
                                        child: Text(
                                          "$programa",
                                          style: TextStyle(
                                            fontSize: SizeConfig.of(context)
                                                .dynamicScale(size: 20),
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navegador().goToPerfilChgPrograma(
                                        context, programa);
                                  },
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: TrashColors().buttonColor),
                                ),
                              )
                            ],
                          )),
                    ]));
          } else if (snapshot.hasError) {
            return Text("Error, ${snapshot.error}",
                style: TextStyle(fontSize: 35));
          } else {
            return Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Text("Programa",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[300]))),
                      Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    Navegador()
                                        .goToPerfilChgName(context, user);
                                  },
                                  child: Text(
                                    "Não participa",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  )),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navegador()
                                        .goToPerfilChgName(context, user);
                                  },
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.grey[300]),
                                ),
                              )
                            ],
                          )),
                    ]));
          }
        });
  }
}
