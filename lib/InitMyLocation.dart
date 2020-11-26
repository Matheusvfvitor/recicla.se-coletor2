import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class InitMyLocation {
  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void myLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      var time = DateTime.now().millisecondsSinceEpoch;
      var currentUser = _firebaseAuth.currentUser;
      Map<String, dynamic> obj = {
        "lat": _currentPosition.latitude,
        "lng": _currentPosition.longitude,
        "country": place.country,
        "administrativeArea": place.administrativeArea,
        "locality": place.locality,
        "name": place.name,
        "postalCode": place.postalCode,
        "subLocality": place.subLocality,
        "subThoroughfare": place.subThoroughfare,
        "thoroughfare": place.thoroughfare,
      };
      db
          .collection("user_activity")
          .doc(currentUser.uid)
          .collection("myLocation")
          .doc(time.toString())
          .set(obj)
          .then((value) {
        print("sucesso");
      });
    } catch (e) {
      print(e);
    }
  }
}
