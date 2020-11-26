import 'package:ansicolor/ansicolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'TrashCanInfo.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
//String currUser = auth.currentUser.uid;
String currUser = auth.currentUser.uid.toString();
AnsiPen yellowPen = AnsiPen()..yellow();
AnsiPen redPen = AnsiPen()..red();
AnsiPen greenPen = AnsiPen()..green();

class FirebaseAcompanhamento {
  Future<QuerySnapshot> getTrashCansOnGoing() async {
    QuerySnapshot query = await db
        .collection('picker_activity/$currUser/trashcans')
        .where('status', isLessThan: 5)
        .get()
        .whenComplete(() => print(greenPen('got the docs !')))
        .catchError((onError) => {print(redPen(onError))});
    return query;
  }

  Future<QuerySnapshot> getTrashCansFinished() async {
    QuerySnapshot query = await db
        .collection('picker_activity/$currUser/trashcans')
        .where('status', isEqualTo: 5)
        .get()
        .whenComplete(() => print(greenPen('got the docs !')))
        .catchError((onError) => {print(redPen(onError))});
    return query;
  }

  Future<void> updateRating(TrashCanInfo trash, double rating) async {
    db
        .doc(
            'user_activity/$currUser/trashcans/${trash.scheduleDate.toString()}')
        .update({'rating': rating})
        .whenComplete(() => print(greenPen('Rating up-to_date')))
        .catchError((onError) => {print(redPen(onError))});
  }

  Future<QuerySnapshot> getTrashLocation(int time) {
    User usuarioLogado = auth.currentUser;
    String _currUser = usuarioLogado.uid.toString();
    var docref = db
        .collection("user_activity")
        .doc(_currUser)
        .collection("trashcans")
        .doc(time.toString())
        .collection("trash_location")
        .get();

    return docref;
  }

  Future<void> deleteTrashCan(
    int id,
  ) async {
    db
        .collection("user_activity")
        .doc(currUser)
        .collection("trashcans")
        .doc(id.toString())
        .delete();
  }
}
