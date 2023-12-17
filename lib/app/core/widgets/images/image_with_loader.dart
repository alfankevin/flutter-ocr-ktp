import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'empty_image.dart';

class ImageWithLoader extends StatelessWidget {
  const ImageWithLoader({
    super.key,
    required this.imageUrl,
    this.size = 125,
    this.width,
    this.height,
    this.radius,
    this.child,
    this.boxShadow,
    this.borderRadius,
    this.isBG = false,
    this.fit,
    this.border,
  });

  final String imageUrl;
  final double size;
  final double? width;
  final double? height;
  final double? radius;
  final Widget? child;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry? borderRadius;
  final bool isBG;
  final BoxFit? fit;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return imageUrl == ''
        ? EmptyImage(
            size: size,
            width: width,
            height: height,
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.white,
              child: EmptyImage(
                size: size,
                width: width,
                height: height,
                radius: radius,
              ),
            ),
            imageBuilder: (context, imageProvider) => Container(
              height: width,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit ?? BoxFit.cover,
                ),
                boxShadow: boxShadow,
                border: border,
              ),
              child: child,
            ),
            errorWidget: (context, url, error) => isBG
                ? Container(
                    height: width,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      color: Colors.white,
                      boxShadow: boxShadow,
                    ),
                  )
                : EmptyImage(
                    size: size,
                    width: width,
                    height: height,
                    radius: radius,
                    child: const Center(
                      child: Icon(CupertinoIcons.photo, color: Colors.grey),
                    ),
                  ),
          );
  }
}
