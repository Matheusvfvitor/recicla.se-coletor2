import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'FirebaseAcompanhamento.dart';
import 'FirebaseGetTrashs.dart';
import 'MyRequestFinishedCard.dart';
import 'ShimmerList.dart';

Widget _widget = Container(width: 0.0, height: 0.0);

class AcompanhamentoListFinished extends StatefulWidget {
  @override
  _AcompanhamentoListFinishedState createState() =>
      _AcompanhamentoListFinishedState();
}

class _AcompanhamentoListFinishedState
    extends State<AcompanhamentoListFinished> {
  Widget widgetReturn;
  @override
  Widget build(BuildContext context) {
    var trashcanslist = new List<TrashData>();
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseAcompanhamento().getTrashCansFinished(),
        builder: (context, query) {
          if (query.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                ShimmerList(),
                SizedBox(
                  height: 8,
                ),
                ShimmerList(),
                SizedBox(
                  height: 8,
                ),
                ShimmerList()
              ],
            );
          } else {
            trashcanslist.clear();
            query.data.docs.forEach((document) {
              var doc = document.data();
              trashcanslist.add(
                TrashData(
                    location: Location(
                        city: doc['city'],
                        lat: doc['lat'],
                        lng: doc['lng'],
                        neighbord: doc['neighbord'],
                        number: doc['number'],
                        state: doc['state'],
                        street: doc['street'],
                        tag: doc['tag'],
                        zip: doc['zip']),
                    trashcan: TrashCan(
                      recycleDate: doc['recycleDate'],
                      confirmDate: doc['confirmDate'],
                      id: doc['id'],
                      periodo: doc['periodo'],
                      picker: doc['picker'],
                      qty: double.parse(double.parse(doc['qty'].toString())
                          .toStringAsFixed(2)),
                      rating: 0.0,
                      recycler: doc['recycler'],
                      scheduleDate: doc['scheduleDate'],
                      status: double.parse(doc['status'].toString()),
                      weight: double.parse(doc['weight'].toString()),
                      tcoins: double.parse(doc['tCoins'].toString()),
                    ),
                    trashItemList: List<TrashItem>()),
              );
              print('doc added: $doc');
              trashcanslist = trashcanslist.reversed.toList();
            });
            if (trashcanslist.length <= 0) {
              widgetReturn = Container(width: 0.0, height: 0.0);
            } else {
              widgetReturn = ListView.builder(
                  itemCount: trashcanslist.length,
                  itemBuilder: (context, index) {
                    return MyRequestFinishedCard(
                      trash: trashcanslist[index],
                      rating: trashcanslist[index].trashcan.rating,
                      date: trashcanslist[index].trashcan.scheduleDate,
                      stage: trashcanslist[index].trashcan.status,
                      trashcoins: trashcanslist[index].trashcan.tcoins,
                      weight: trashcanslist[index].trashcan.weight,
                    );
                  });
            }

            return widgetReturn;
            /*ListView.builder(
            itemCount: trashcanslist.length,
            itemBuilder: (context, index) {
              return MyRequestFinishedCard(
                trash: trashcanslist[index],
                rating: trashcanslist[index].rating,
                date: trashcanslist[index].scheduleDate,
                stage: trashcanslist[index].status,
                trashcoins: trashcanslist[index].tcoins,
                weight: trashcanslist[index].weight,
              );
            });*/
          }
        });
  }
}
