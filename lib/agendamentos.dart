import 'package:flutter/material.dart';

import 'AcompanhamentListFinished.dart';
import 'AcompanhamentoList.dart';
import 'Home.dart';
import 'TrashColors.dart';

Widget _widget = Container();

class MySchedules extends StatefulWidget {
  @override
  _MySchedulesState createState() => _MySchedulesState();
}

class _MySchedulesState extends State<MySchedules> {
  double rating = 1;
  double newRating = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: TrashColors().backgroundgreen,
              appBar: AppBar(
                  title: Text("Minhas Coletas"),
                  backgroundColor: TrashColors().whatsgreen,
                  centerTitle: true,
                  leading: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                      }),
                  bottom: TabBar(
                    tabs: [Tab(text: "Ativas"), Tab(text: "Finalizadas")],
                    indicatorColor: TrashColors().highlightButton,
                  )),
              body: TabBarView(children: [
                PageView(
                  children: [
                    Container(
                        color: TrashColors().backgroundgreen,
                        child: Column(
                          children: [
                            Expanded(child: AcompanhamentoList()),
                          ],
                        )),
                  ],
                ),
                PageView(
                  children: [
                    Container(
                        child: Column(
                      children: [Expanded(child: AcompanhamentoListFinished())],
                    )),
                  ],
                )
              ]),
            )));
  }
}
