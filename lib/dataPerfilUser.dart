import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'Navegador.dart';
import 'SizeConfig.dart';
import 'TrashColors.dart';
import 'Users.dart';

class DataPerilUser extends StatefulWidget {
  final Users user;
  DataPerilUser({this.user});
  @override
  _DataPerilUserState createState() => _DataPerilUserState();
}

class _DataPerilUserState extends State<DataPerilUser> {
  Users user = Users();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users>(
        future: Users().getuser(),
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
            print("NomeUser snapshot ${snapshot.data.name}");

            user.name = snapshot.data.name;
            user.email = snapshot.data.email;
            user.fotoPerfil = snapshot.data.fotoPerfil;
            user.celular = snapshot.data.celular;
            user.primeiroLogin = snapshot.data.primeiroLogin;
            user.uId = snapshot.data.uId;
            user.urifoto = snapshot.data.urifoto;

            if (user.celular == "") {
              user.celular = "Adicione um número de telefone";
            }

            return Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Text("Nome",
                              style: TextStyle(
                                  fontSize: SizeConfig.of(context)
                                      .dynamicScale(size: 20),
                                  color: Colors.grey[400]))),
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
                                    "${user.name}",
                                    style: TextStyle(
                                      fontSize: SizeConfig.of(context)
                                          .dynamicScale(size: 20),
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
                                      color: TrashColors().buttonColor),
                                ),
                              )
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Text("Email",
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
                                    children: <Widget>[
                                      Icon(Icons.email),
                                      Text(" "),
                                      GestureDetector(
                                        onTap: null,
                                        child: Text(
                                          "${user.email}",
                                          style: TextStyle(
                                            fontSize: SizeConfig.of(context)
                                                .dynamicScale(size: 20),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container()
                              ])),
                      Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Text("Telefone",
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
                                    children: <Widget>[
                                      Icon(Icons.phone),
                                      Text(" "),
                                      GestureDetector(
                                        onTap: () {
                                          Navegador().goToPerfilChgTelefone(
                                              context, user);
                                        },
                                        child: Text(
                                          "${user.celular}",
                                          style: TextStyle(
                                            fontSize: SizeConfig.of(context)
                                                .dynamicScale(size: 20),
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navegador()
                                          .goToPerfilChgTelefone(context, user);
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: TrashColors().buttonColor,
                                    ),
                                  ),
                                )
                              ])),
                      Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Text("Endereço",
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
                                    children: <Widget>[
                                      Icon(Icons.map),
                                      Text(" "),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          "Acesse seus endereços",
                                          style: TextStyle(
                                            fontSize: SizeConfig.of(context)
                                                .dynamicScale(size: 20),
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: TrashColors().buttonColor,
                                    ),
                                  ),
                                )
                              ]))
                    ]));
          } else if (snapshot.hasError) {
            return Text("Erro ao carregar, ${snapshot.error}",
                style: TextStyle(fontSize: 35));
          } else {
            return Text("Erro ao carregar", style: TextStyle(fontSize: 35));
          }
        });
  }
}
