import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String currUser = auth.currentUser.uid;

class GetTrashs {
  FirebaseFirestore db = FirebaseFirestore.instance;

  var itemList = new List<TrashItem>();
  var trashList = new List<TrashData>();

  Future<List<TrashData>> getTrashs() async {
    QuerySnapshot trashs = await db.collection('user_activity').get();

    trashs.docs.forEach((user) async {
      itemList.clear();
      QuerySnapshot trashs = await db
          .collection('user_activity/${user.id}/trashcans')
          .where('status', isLessThan: 3)
          .get();

      trashs.docs.forEach((trashSnp) async {
        DocumentSnapshot trashDataObj = await db
            .doc('user_activity/${user.id}/trashcans/${trashSnp.id}')
            .get();

        QuerySnapshot trashLocationSnp = await db
            .collection(
                'user_activity/${user.id}/trashcans/${trashSnp.id}/trash_location/')
            .get();
        Map<String, dynamic> trashLocationObj =
            trashLocationSnp.docs.first.data();

        double lat = trashLocationObj['lat'];
        double lng = trashLocationObj['lng'];
        String tag = trashLocationObj['tag'];
        String street = trashLocationObj['street'];
        String neighbord = trashLocationObj['neighbord'];
        String city = trashLocationObj['city'];
        String state = trashLocationObj['state'];
        String zip = trashLocationObj['zip'];
        String number = trashLocationObj['number'];

        Location location = Location(
            lat: lat,
            lng: lng,
            tag: tag,
            street: street,
            neighbord: neighbord,
            city: city,
            state: state,
            zip: zip,
            number: number);

        var id = trashSnp.id.toString();
        String periodo = trashDataObj['periodo'];
        String picker = trashDataObj['picker'];
        double qty = double.parse(
            double.parse(trashDataObj['qty'].toString()).toStringAsFixed(2));
        double rating = double.parse(trashDataObj['rating'].toString());
        String recycler = trashDataObj['recycler'];
        int scheduleDate = trashDataObj['scheduleDate'];
        double status = double.parse(
            double.parse(trashDataObj['status'].toString()).toStringAsFixed(2));
        ;
        double tcoins = trashDataObj['tCoins'];
        double weight = trashDataObj['weight'];

        TrashCan trash = TrashCan(
            id: id,
            periodo: periodo,
            picker: picker,
            qty: qty,
            rating: rating,
            recycler: recycler,
            scheduleDate: scheduleDate,
            status: status,
            tcoins: tcoins,
            weight: weight);

        QuerySnapshot itens = await db
            .collection(
                'user_activity/${user.id}/trashcans/${trash.id}/trash_item/')
            .get();

        itemList.clear();
        itens.docs.forEach((item) async {
          Map<String, dynamic> obj = item.data();
          double gperUnity = obj['gPerUnity'];
          String iconData = obj['iconCode'];
          String iconDesc = obj['icon'];
          String longDesc = obj['longDesc'];
          String material = obj['material'];
          String name = obj['name'];
          String shortDesc = obj['shortDesc'];
          String unity = obj['unity'];
          String curiosity = obj['curiosity'];
          String description = obj['description'];
          String image = obj['image'];

          itemList.add(TrashItem(
              curiosity: curiosity,
              description: description,
              iconData: iconData,
              iconDesc: iconDesc,
              material: material,
              name: name,
              longDesc: longDesc,
              gperUnit: gperUnity,
              shortDesc: shortDesc,
              unity: unity,
              image: image));
        });

        trashList.add(TrashData(
            /*itens: itemList, */ location: location,
            trashcan: trash));
        print(trashList.length.toString());
        /*print(
            'user: ${user.id} trashId : ${trash.id} - itens: ${itemList.length}');*/
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      print(trashList.length);
      return trashList;
    });
  }
}

class TrashData {
  TrashCan trashcan;
  Location location;
  List<TrashItem> trashItemList;
  String userName;
  //List<TrashItem> itens;

  TrashData(
      {/*this.itens,*/ this.location,
      this.trashcan,
      this.userName,
      this.trashItemList});
}

class TrashCan {
  String id;
  String periodo;
  String picker;
  double qty;
  double rating;
  String recycler;
  int scheduleDate;
  double status;
  double tcoins;
  double weight;
  int confirmDate;
  int recycleDate;

  TrashCan(
      {this.id,
      this.periodo,
      this.picker,
      this.qty,
      this.rating,
      this.recycler,
      this.scheduleDate,
      this.status,
      this.weight,
      this.tcoins,
      this.confirmDate,
      this.recycleDate});
}

class Location {
  double lat;
  double lng;
  String tag;
  String street;
  String neighbord;
  String city;
  String state;
  String zip;
  String number;

  Location(
      {this.lat,
      this.lng,
      this.tag,
      this.street,
      this.state,
      this.city,
      this.neighbord,
      this.number,
      this.zip});
}

class TrashItem {
  double gperUnit;
  String longDesc;
  String material;
  String name;
  String shortDesc;
  String unity;
  String iconDesc;
  String iconData;
  String curiosity;
  String description;
  String image;
  int quantity;
  double weight;

  TrashItem(
      {this.gperUnit,
      this.longDesc,
      this.material,
      this.name,
      this.shortDesc,
      this.unity,
      this.quantity,
      this.iconData,
      this.iconDesc,
      this.curiosity,
      this.description,
      this.image,
      this.weight});
}
