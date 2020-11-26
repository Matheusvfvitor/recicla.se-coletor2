import 'package:flutter/material.dart';
import 'package:reciclase_coletor/TrashColors.dart';

import 'agendamentos.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        color: TrashColors().appBarBackGround,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(8),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    Text("Home",
                        style: TextStyle(fontSize: 14, color: Colors.white))
                  ],
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MySchedules()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.today,
                      color: Colors.white,
                    ),
                    Text("Agenda",
                        style: TextStyle(fontSize: 14, color: Colors.white))
                  ],
                )),
              ),
            ),
            GestureDetector(
              onTap: null,
              child: Container(
                margin: EdgeInsets.all(8),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    Text("Perfil",
                        style: TextStyle(fontSize: 14, color: Colors.white))
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
