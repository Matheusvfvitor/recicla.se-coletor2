import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FirebaseDocuments.dart';
import 'notificationCard.dart';

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var image;
    var shortDesc;
    var longDesc;

    var cardNotif = List<NotificationCard>();

    return FutureBuilder<QuerySnapshot>(
        future: FirebaseDocuments().notificationCards(),
        builder: (context, query) {
          if (query.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.grey[700],
            ));
          } else if (query.hasData) {
            query.data.docs.forEach((doc) {
              var obj = doc.data();
              print("aqui estou ${doc.data()}");
              image = obj["image"];
              shortDesc = obj["short_desc"];
              longDesc = obj["long_desc"];

              cardNotif.add(NotificationCard(
                image: image,
                shortTitle: shortDesc,
                description: longDesc,
              ));

              return ListView.builder(
                  itemCount: cardNotif.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      Container(
                        //height: 120,
                        //color: Colors.black12,
                        //margin: EdgeInsets.only(bottom: 4),
                        padding: EdgeInsets.all(4),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            NotificationCard(
                              image: "${cardNotif[index].image}",
                              description: "${cardNotif[index].description}",
                              shortTitle: "${cardNotif[index].shortTitle}",
                            )
                          ],
                        ),
                      )
                    ]);
                  });
            });
          } else {
            return Text("error");
          }
        });
  }
}
