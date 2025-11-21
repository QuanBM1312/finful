import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

import '../../../constants/images.dart';
import '../../../theme/colors.dart';

enum FinfulImageType { networkToFile, asset, network }

class FinfulImage extends StatelessWidget {
  const FinfulImage({
    super.key,
    required this.type,
    required this.source,
    this.file,
    this.enableDebug = true,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.loadingWidget,
    this.customAssetImage,
    this.filterQuality = FilterQuality.high,
    this.excludeFromSemantics = false,
    this.borderRadius = BorderRadius.zero,
  });

  final FinfulImageType type;
  final String? source;
  final File? file;
  final bool enableDebug;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final AssetImage? customAssetImage;
  final FilterQuality filterQuality;
  final bool excludeFromSemantics;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final fBorderRadius = borderRadius ?? BorderRadius.zero;

    if (type == FinfulImageType.networkToFile) {
      return ClipRRect(
        borderRadius: fBorderRadius,
        child: Image(
          key: key,
          image: NetworkToFileImage(
            url: source,
            file: file,
            debug: enableDebug,
          ),
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return loadingWidget ??
                Container(
                  color: FinfulColor.backgroundLight,
                  child: FinfulImage(
                    type: FinfulImageType.asset,
                    source: ImageConstants.imgDefaultCard,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
          errorBuilder: (_, error, stackTrace) {
            return errorWidget ??
                Container(
                  color: FinfulColor.backgroundLight,
                  child: FinfulImage(
                    type: FinfulImageType.asset,
                    source: ImageConstants.imgDefaultCard,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
          height: height,
          width: width,
          fit: fit,
          excludeFromSemantics: excludeFromSemantics,
          filterQuality: filterQuality,
        ),
      );
    }

    if (type == FinfulImageType.asset) {
      return ClipRRect(
        borderRadius: fBorderRadius,
        child: Image(
          image: customAssetImage ?? AssetImage(source ?? ''),
          height: height,
          width: width,
          fit: fit,
          excludeFromSemantics: excludeFromSemantics,
          filterQuality: filterQuality,
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return loadingWidget ??
                Container(
                  color: FinfulColor.backgroundLight,
                  child: FinfulImage(
                    type: FinfulImageType.asset,
                    source: ImageConstants.imgDefaultCard,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
          errorBuilder: (_, error, stackTrace) {
            return errorWidget ??
                Container(
                  color: FinfulColor.backgroundLight,
                  child: FinfulImage(
                    type: FinfulImageType.asset,
                    source: ImageConstants.imgDefaultCard,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
        ),
      );
    }

    if (type == FinfulImageType.network) {
      return ClipRRect(
        borderRadius: fBorderRadius,
        child: Image.network(
          source ?? '',
          height: height,
          width: width,
          fit: fit,
          excludeFromSemantics: excludeFromSemantics,
          filterQuality: filterQuality,
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return loadingWidget ??
                Container(
                  color: FinfulColor.backgroundLight,
                  child: FinfulImage(
                    type: FinfulImageType.asset,
                    source: ImageConstants.imgDefaultCard,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
          errorBuilder: (_, error, stackTrace) {
            return errorWidget ??
                Container(
                  color: FinfulColor.backgroundLight,
                  child: FinfulImage(
                    type: FinfulImageType.asset,
                    source: ImageConstants.imgDefaultCard,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
        ),
      );
    }

    return const SizedBox();
  }
}
