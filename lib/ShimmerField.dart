import 'package:flutter/material.dart';
import 'SizeConfig.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerField extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerField({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        height: SizeConfig.of(context).dynamicScaleHeight(size: 160),
        child: Center(
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    //margin: EdgeInsets.all(2),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.purple),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
