import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'empty_image.dart';
import 'image_generator.dart';

class UserCircleAvatar extends StatelessWidget {
  const UserCircleAvatar({
    super.key,
    required this.image,
    this.size,
    required this.name,
  });

  final String? image;
  final double? size;
  final String name;

  @override
  Widget build(BuildContext context) {
    if (image == null ||
        image == '' ||
        image == 'default.png' ||
        image?.split('/').last == 'default.png') {
      return ImageGenerator(
        name: name,
        size: size ?? 50,
      );
    }
    return CachedNetworkImage(
      imageUrl: image!,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.white,
        child: const EmptyImage(
          size: 50,
        ),
      ),
      width: size,
      height: size,
      errorWidget: (context, url, error) => ImageGenerator(
        name: name,
        size: size ?? 50,
      ),
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          radius: 30,
          backgroundImage: imageProvider,
        );
      },
    );
  }
}
