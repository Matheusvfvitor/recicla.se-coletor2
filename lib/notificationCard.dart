import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  final String image;
  final String description;
  final String shortTitle;

  const NotificationCard(
      {Key key, this.image, this.description, this.shortTitle})
      : super(key: key);

  @override
  _NotificationCard createState() => _NotificationCard();
}

class _NotificationCard extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.50),
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                widget.image,
              ),
              fit: BoxFit.cover,
            )),
          )),
          Text(widget.shortTitle),
          Text(widget.description),
        ],
      ),
    );
  }
}
