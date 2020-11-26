import 'package:flutter/material.dart';

import 'SizeConfig.dart';

class InfiniteButtonColor extends StatelessWidget {
  final Function action;
  final String text;
  final Color color;

  const InfiniteButtonColor({Key key, this.action, this.text, this.color})
      : super(key: key);

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
          color: color,
          textColor: Colors.white,
          onPressed: action,
          child: Text(
            text,
            style: TextStyle(
                fontSize: SizeConfig.of(context).dynamicScale(size: 16)),
          ),
        ),
      ),
    );
  }
}
