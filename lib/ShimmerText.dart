import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerText extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerText({Key key, this.width, this.height}) : super(key: key);

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
                  margin: EdgeInsets.all(8),
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.purple),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
