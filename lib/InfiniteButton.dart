import 'package:flutter/material.dart';
import 'TrashColors.dart';

class InfiniteButton extends StatelessWidget {
  final Function action;
  final String text;

  const InfiniteButton({Key key, this.action, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white70,
      ),
      child: SizedBox(
        height: 54,
        width: double.infinity,
        child: RaisedButton(
          color: TrashColors().buttonColor,
          textColor: Colors.white,
          onPressed: action,
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
