import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AuxClass.dart';
import 'FirebaseGetTrashs.dart';

class FireTrash {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String currUser = auth.currentUser.uid.toString();

  Future<QuerySnapshot> getUsersActivities() async {
    QuerySnapshot users = await db.collection('user_activity').get();
    return users;
  }

  Future<QuerySnapshot> getTrashs(String userid) async {
    QuerySnapshot trashs = await db
        .collection('user_activity/$userid/trashcans')
        .where('status', isLessThan: 3)
        .get();

    return trashs;
  }

  Future<QuerySnapshot> getItens(String userid, String trashcanid) async {
    QuerySnapshot itens = await db
        .collection('user_activity/$userid/trashcans/$trashcanid/trash_item/')
        .get();
    return itens;
  }

  Future<QuerySnapshot> getLocation(String userid, String trashcanid) async {
    QuerySnapshot trashLocationSnp = await db
        .collection(
            'user_activity/$userid/trashcans/$trashcanid/trash_location/')
        .get();
    return trashLocationSnp;
  }

  Future<QuerySnapshot> getTrashsInfo() async {
    var users = await getUsersActivities();
    users.docs.forEach((user) {
      String userid = user.id;
      getTrashs(userid);
    });
  }

  Future<DocumentSnapshot> getUserInfo(String uid) async {
    var userSnp = await db.doc('users/$uid');
    var userData = userSnp.get();
    return userData;
  }

  Future<void> coletar(BuildContext, context, TrashData trash) {
    // Alterar o status do Resíduo para 5
    db
        .doc(
            '/user_activity/${trash.trashcan.recycler}/trashcans/${trash.trashcan.recycleDate.toString()}')
        .update({
      'status': 5,
      'picker': currUser,
    }).then((value) => print('Trash Atualizado'));

    // Adicionar coleta para o Picker
    var now = DateTime.now().millisecondsSinceEpoch;
    updatePicker(5, now, trash);

    //Adicionar ao PickerActivity
    db.doc('picker_activity/$currUser/trashcans/${now.toString()}').set({
      'picker': currUser,
      'weight': trash.trashcan.weight,
      'recyclerID': trash.trashcan.recycler,
      'recycler': trash.trashcan.recycler,
      'scheduleDate': trash.trashcan.scheduleDate,
      'tCoins': trash.trashcan.tcoins,
      'qty': trash.trashcan.qty,
      'status': 5,
      'lat': trash.location.lat,
      'lng': trash.location.lng,
      'city': trash.location.city,
      'neighbord': trash.location.neighbord,
      'number': trash.location.number,
      'state': trash.location.state,
      'street': trash.location.street,
      'zip': trash.location.zip,
      'userTag': trash.location.tag,
      'confirmDate': now,
      'recycleDate': trash.trashcan.recycleDate,
    });

    //Update Trashcoin Balance
    updateTCoins(trash);

    //Enviando a Notificação para o usuário !
    String message =
        'Seu resíduo foi coletado e ${trash.trashcan.tcoins} TrashCoins foram adicionados ao seu saldo';
    String title = 'Resíduo Coletado';
    DateTime data = DateTime.now();
    sendNotification(message, data, title, trash);

    //Atualizar a user_activity
    updateUserActivity(trash);

    showDialog(
        context: context,
        builder: (dialogContex) {
          return Dialog(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Resíduo Coleta com sucesso !',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(dialogContex).pop();
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> updateUserActivity(TrashData trash) async {
    String userid = trash.trashcan.recycler.toString();
    String trashId = trash.trashcan.id.toString();
    var itemList = List<TrashItem>();

    print(userid);
    print(trashId);

    itemList.clear();

    QuerySnapshot trashItens = await db
        .collection('user_activity/$userid/trashcans/$trashId/trash_item')
        .get();

    trashItens.docs.forEach((trashElement) async {
      Map<String, dynamic> trashItem = trashElement.data();
      String curiosity = trashItem['curiosity'];
      String description = trashItem['description'];
      double gPerUnity = double.parse(trashItem['gPerUnity'].toString());
      String icon = trashItem['icon'];
      String iconCode = trashItem['iconCode'];
      String image = trashItem['image'];
      String longDesc = trashItem['longDesc'];
      String material = trashItem['material'];
      String name = trashItem['name'];
      int quantity = trashItem['quantity'];
      String shortDesc = trashItem['shortDesc'];
      String unity = trashItem['unity'];
      double weight = trashItem['weight'];

      itemList.add(TrashItem(
          curiosity: curiosity,
          description: description,
          gperUnit: gPerUnity,
          iconData: iconCode,
          iconDesc: icon,
          image: image,
          longDesc: longDesc,
          quantity: quantity,
          material: material,
          name: name,
          shortDesc: shortDesc,
          unity: unity,
          weight: weight));
    });

    double totMet = 0.0;
    double totPap = 0.0;
    double totVid = 0.0;
    double totPl = 0.0;
    double nMet = 0.0;
    double nPap = 0.0;
    double nPl = 0.0;
    double nVid = 0.0;
    double totN = 0.0;
    double totKg = 0.0;

    print(trash.trashcan.id);

    itemList.forEach((res) {
      print('item:  ${res.material}');
      switch (res.material) {
        case 'Plástico':
          {
            totPl += res.weight / 1000;
            nPl += res.quantity;
          }
          break;
        case 'Alumínio':
          {
            totMet += res.weight / 1000;
            nMet += res.quantity;
          }
          break;
        case 'Papel':
          {
            totPap += res.weight / 1000;
            nPap += res.quantity;
          }
          break;
        case 'Vidro':
          {
            totVid += res.weight / 1000;
            nVid += res.quantity;
          }
          break;
        default:
      }
      totKg += res.weight / 1000;
      totN += res.quantity;
    });

    print(
        'totkg: ${totKg.toString()} totN: ${totN.toString()} totMet: ${totMet.toString()} totPap: ${totPap.toString()} totPl: ${totPl.toString()} totVid: ${totVid.toString()}');

    //Buscar dados atuais do userActivity
    var activity = await db.doc('user_activity/$userid').get();
    Map<String, dynamic> userDataObj = activity.data();

    var nitem_met = double.parse(userDataObj['nitem_met'].toString());
    var nitem_pap = double.parse(userDataObj['nitem_pap'].toString());
    var nitem_pl = double.parse(userDataObj['nitem_pl'].toString());
    var nitem_vid = double.parse(userDataObj['nitem_vid'].toString());
    var peso = double.parse(userDataObj['peso'].toString());
    var tcoins = double.parse(userDataObj['tcoins'].toString());

    var kg_met = double.parse(userDataObj['kg_met'].toString());
    var kg_pap = double.parse(userDataObj['kg_pap'].toString());
    var kg_pl = double.parse(userDataObj['kg_pl'].toString());
    var kg_vid = double.parse(userDataObj['kg_vid'].toString());

    nitem_met += nMet;
    nitem_pap += nPap;
    nitem_pl += nPl;
    nitem_vid += nVid;

    peso += totKg;
    tcoins += trash.trashcan.tcoins;

    kg_met += totMet;
    kg_pap += totPap;
    kg_pl += totPl;
    kg_vid += totVid;

    db.doc('user_activity/$userid').update({
      'kg_met': kg_met,
      'kg_pap': kg_pap,
      'kg_vid': kg_vid,
      'kg_pl': kg_pl,
      'nitem_met': nitem_met,
      'nitem_pap': nitem_pap,
      'nitem_pl': nitem_pl,
      'nitem_vid': nitem_vid,
      'peso': peso,
      'tcoins': tcoins,
    });
  }

  Future<void> sendNotification(
      String message, DateTime date, String title, TrashData trash) {
    Map<String, dynamic> notification = {
      'date': date,
      'message': message,
      'title': title
    };

    db
        .collection('user_activity/${trash.trashcan.recycler}/notifications')
        .add(notification)
        .then((value) => print('notificação enviada'));
  }

  Future<void> updateTCoins(TrashData trash) {
    var now = DateTime.now().microsecondsSinceEpoch;
    db
        .doc(
            'user_activity/${trash.trashcan.recycler}/trashcoins/${now.toString()}')
        .set({
      'category': 'Crédito Reciclagem',
      'date': now,
      'full_desc': 'Crédito por reciclar',
      'tipo': 1,
      'value': trash.trashcan.tcoins
    }).then((value) =>
            print('TCoins Atualizados : ${trash.trashcan.tcoins.toString()}'));
  }

  Future<void> updatePicker(double status, int pickDate, TrashData trash) {
    var now = DateTime.now();
    db.doc('picker_activity/$currUser/picks/$now').set({
      'picker': currUser,
      'pickDate': pickDate,
      'weight': trash.trashcan.weight,
      'recyclerID': trash.trashcan.recycler,
      'recycler': trash.trashcan.recycler,
      'scheduleDate': trash.trashcan.scheduleDate,
      'tCoins': trash.trashcan.tcoins,
      'qty': trash.trashcan.qty,
      'status': status,
      'lat': trash.location.lat,
      'lng': trash.location.lng,
      'city': trash.location.city,
      'confirmDate': trash.trashcan.confirmDate,
      'neighbord': trash.location.neighbord,
      'number': trash.location.number,
      'state': trash.location.state,
      'street': trash.location.street,
      'zip': trash.location.zip,
      'userTag': trash.location.tag
    }).then((value) => print('Pick atualizada'));
  }

  Future<void> updatePickerActivity(String id, int status) {
    db.doc('picker_activity/$currUser/trashcans/$id').update({
      'status': status,
    });
  }

  Future<void> agendamento(TrashData trash) {
    //Enviar para picker_activity
    var now = DateTime.now().millisecondsSinceEpoch;
    db.doc('picker_activity/$currUser/trashcans/${now.toString()}').set({
      'picker': currUser,
      'weight': trash.trashcan.weight,
      'recyclerID': trash.trashcan.recycler,
      'recycler': trash.trashcan.recycler,
      'scheduleDate': trash.trashcan.scheduleDate,
      'tCoins': trash.trashcan.tcoins,
      'qty': trash.trashcan.qty,
      'status': 2,
      'lat': trash.location.lat,
      'lng': trash.location.lng,
      'city': trash.location.city,
      'neighbord': trash.location.neighbord,
      'number': trash.location.number,
      'state': trash.location.state,
      'street': trash.location.street,
      'zip': trash.location.zip,
      'userTag': trash.location.tag,
      'confirmDate': now,
      'recycleDate': trash.trashcan.recycleDate,
    });
    //Atualizar Status da coleta
    db
        .doc(
            '/user_activity/${trash.trashcan.recycler}/trashcans/${trash.trashcan.recycleDate.toString()}')
        .update({
      'status': 3,
      'picker': currUser,
    }).then((value) => print('Trash Atualizado'));
    //Enviar Notificação
    var cDate =
        new DateTime.fromMillisecondsSinceEpoch(trash.trashcan.scheduleDate);

    String month = AuxClass().convertMonth(cDate.month);
    String wday = AuxClass().convertWeekdDay(cDate.weekday);
    print(trash.trashcan.scheduleDate);

    String message =
        'Eba, sua coleta está confirmada para: $wday , ${cDate.day} de $month';
    String title = 'Coleta Confirmada';
    DateTime data = DateTime.now();

    sendNotification(message, data, title, trash);
  }
}
