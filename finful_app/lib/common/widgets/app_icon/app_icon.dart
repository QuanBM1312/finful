import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/dimensions.dart';

class AppSvgIcon extends StatelessWidget {
  final String asset;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  const AppSvgIcon(
    this.asset, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      fit: fit ?? BoxFit.cover,
      width: width ?? Dimens.p_24,
      height: height ?? Dimens.p_24,
      color: color,
      semanticsLabel: asset.toString(),
    );
  }
}
