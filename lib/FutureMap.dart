import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'FireTrash.dart';
import 'FirebaseGetTrashs.dart';

var trashList = new List<TrashData>();
var trashItemList = new List<TrashItem>();

Position _currentPosition;
String _currentAddress;
String username = "";
LatLng latlng = LatLng(-23.6503972, -46.5426122);
Set<Marker> markers = new Set<Marker>();

class FutureMap extends StatefulWidget {
  @override
  _FutureMapState createState() => _FutureMapState();
}

class _FutureMapState extends State<FutureMap> {
  Completer<GoogleMapController> _controller = Completer();

  String len = '';
  @override
  Widget build(BuildContext context) {
    Widget _final = Container();

    return FutureBuilder(
        future: FireTrash().getUsersActivities(),
        builder: (context, AsyncSnapshot<QuerySnapshot> query) {
          if (query.connectionState != ConnectionState.done) {
            return Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  strokeWidth: 20,
                ),
              ),
            );
          } else {
            FirebaseFirestore db = FirebaseFirestore.instance;
            trashList.clear();
            query.data.docs.forEach((user) async {
              var userSnp = await db.doc('users/${user.id}');

              var userData = await userSnp.get();
              String userName = "";

              if (userData.exists) {
                userName = userData.data()['name'];
              }

              QuerySnapshot trashs = await db
                  .collection('user_activity/${user.id}/trashcans')
                  .where('status', isLessThan: 3)
                  .get();

              trashs.docs.forEach((trashElement) async {
                Map<String, dynamic> trashDataObj = trashElement.data();
                var id = trashElement.id.toString();
                int recycleDate = trashDataObj['recycleDate'];
                String periodo = trashDataObj['periodo'];
                String picker = trashDataObj['picker'];
                double qty = double.parse(
                    double.parse(trashDataObj['qty'].toString())
                        .toStringAsFixed(2));
                double rating = double.parse(trashDataObj['rating'].toString());
                String recycler = trashDataObj['recycler'];
                int scheduleDate = trashDataObj['scheduleDate'];
                double status = double.parse(
                    double.parse(trashDataObj['status'].toString())
                        .toStringAsFixed(2));

                double tcoins = trashDataObj['tCoins'];
                double weight = trashDataObj['weight'];

                TrashCan trash = TrashCan(
                    recycleDate: recycleDate,
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

                QuerySnapshot trashLocationSnp = await db
                    .collection(
                        'user_activity/${user.id}/trashcans/${trashElement.id}/trash_location/')
                    .get();

                if (trashLocationSnp.size > 0) {
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

                  trashList.add(TrashData(
                      location: location,
                      trashcan: trash,
                      userName: userName.toString(),
                      trashItemList: trashItemList));

                  len = trashList.length.toString();
                  trashList.forEach((trash) {
                    latlng = LatLng(trash.location.lat, trash.location.lng);

                    final Marker marker = Marker(
                        onTap: () {
                          print(trash.trashcan.weight);
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
                                          '${trash.userName} disponibilizou ${trash.trashcan.weight} Kg',
                                          style: TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(dialogContex)
                                                      .pop();
                                                },
                                                child: Text(
                                                  "Cancelar",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                )),
                                            FlatButton(
                                                onPressed: () {
                                                  FireTrash().coletar(
                                                      BuildContext,
                                                      context,
                                                      trash);
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  "Coletar",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                )),
                                            FlatButton(
                                                onPressed: () {
                                                  FireTrash()
                                                      .agendamento(trash);
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  "Agendar",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        markerId: new MarkerId(trash.trashcan.id),
                        position: latlng,
                        infoWindow: InfoWindow(
                            snippet: city, title: trash.trashcan.recycler));

                    markers.add(marker);

                    print(latlng.toString());
                    print('marker added !');
                  });
                  //print(len);
                  //return len;

                }
              });
              print(user.id);
            });
            print(len);
          }
          final Geolocator geolocator = Geolocator()
            ..forceAndroidLocationManager;

          _getCurrentLocation() {
            geolocator
                .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
                .then((Position position) => {
                      _currentPosition = position,
                      latlng = LatLng(_currentPosition.latitude,
                          _currentPosition.longitude),
                      print(position)
                    });
          }

          return GoogleMap(
            markers: Set<Marker>.of(markers), // YOUR MARKS IN MAP
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(zoom: 12, target: latlng),
            onMapCreated: (GoogleMapController controller) async {
              _getCurrentLocation();

              final Marker marker =
                  Marker(markerId: new MarkerId('id'), position: latlng);

              markers.clear();
              trashList.forEach((trash) {
                print(trash.location.lat.toString());
                print(trash.location.lng.toString());
                latlng = LatLng(trash.location.lat, trash.location.lng);

                final Marker marker = Marker(
                    markerId: new MarkerId(trash.trashcan.id),
                    position: latlng);

                markers.add(marker);
                print('marker added !');
              });
              //_controller.complete(controller);
            },
          );
        });
  }
}
