import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        height: 100,
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.purple),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.purple),
                  margin: EdgeInsets.all(8),
                  height: 15,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.purple),
                  margin: EdgeInsets.all(8),
                  height: 15,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.purple),
                  margin: EdgeInsets.all(8),
                  height: 15,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
