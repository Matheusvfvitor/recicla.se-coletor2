import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPhoto extends StatelessWidget {
  final double width;
  final double height;
  final double marginTop;
  final double marginBot;
  final double marginLft;

  const ShimmerPhoto(
      {Key key,
      this.width,
      this.height,
      this.marginTop,
      this.marginBot,
      this.marginLft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: marginTop, bottom: marginBot, left: marginLft),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
