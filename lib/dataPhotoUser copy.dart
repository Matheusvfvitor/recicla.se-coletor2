import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ShimmerPhoto.dart';
import 'Users.dart';

class DataPhotoUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: Users().getImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Future.delayed(Duration(milliseconds: 200));
            return ShimmerPhoto(
              width: 100,
              height: 100,
              marginTop: 50,
              marginBot: 20,
              marginLft: 100,
            );
          } else if (snapshot.hasData) {
            print("foto ${snapshot.data}");
            if (snapshot.data == null) {
              return Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'))));
            } else {
              return Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage('${snapshot.data}'))));
            }
          } else if (snapshot.hasError) {
            return Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'))));
          } else {
            return Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'))));
          }
        });
  }
}
