import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgAssets extends StatelessWidget {
  final String? path;
  final Color? color;
  final BoxFit fit;

  CustomSvgAssets(
      {Key? key, this.path, this.color, this.fit = BoxFit.scaleDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path!,
      fit: BoxFit.scaleDown,
      color: color,
      // height: 25.h,
      // width: 25.w,
    );
  }
}
