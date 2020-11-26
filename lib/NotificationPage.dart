import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TrashColors.dart';
import 'notificationList.dart';

class NotificationPage extends StatefulWidget {
  createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificações"),
        centerTitle: true,
        backgroundColor: TrashColors().appBarBackGround,
      ),
      body: Container(
        color: Colors.blue,
        child: Expanded(
          child: Container(
            child: NotificationList(),
          ),
        ),
      ),
    );
  }
}
