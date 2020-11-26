import 'package:flutter/cupertino.dart';

class SizeConfig {
  final MediaQueryData mediaQueryData;

  SizeConfig({this.mediaQueryData});

  static SizeConfig of(BuildContext context) =>
      SizeConfig(mediaQueryData: MediaQuery.of(context));

  double dynamicScaleAllSizeHeight({double size}) {
    var resize;
    resize = (mediaQueryData.size.height -
            (mediaQueryData.padding.top + mediaQueryData.padding.bottom)) /
        100;
    size = resize * size;
    return size;
  }

  double dynamicScaleAllSizeWidth({double size}) {
    var resize;
    resize = (mediaQueryData.size.width -
            (mediaQueryData.padding.left + mediaQueryData.padding.right)) /
        100;
    size = resize * size;
    return size;
  }

  double dynamicScale({double size}) {
    if (mediaQueryData.size.height <= 600) {
      size = size * 0.74;
    } else if (mediaQueryData.size.height > 600 &&
        mediaQueryData.size.height <= 700) {
      size = size * 0.9;
    } else {
      size = size;
    }
    return size;
  }

  double dynamicScaleHeight({double size}) {
    var resize;
    resize = (mediaQueryData.size.height * 100) / 750;
    size = size * (resize / 100);
    return size;
  }

  double dynamicScaleWidth({double size}) {
    var resize;
    resize = (mediaQueryData.size.width * 100) / 380;
    size = size * (resize / 100);
    return size;
  }
}
