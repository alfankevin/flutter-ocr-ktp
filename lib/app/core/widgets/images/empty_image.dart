import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyImage extends StatelessWidget {
  const EmptyImage({
    super.key,
    this.width,
    this.height,
    this.size,
    this.child,
    this.radius,
  });

  final double? size, width, height;
  final Widget? child;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 50,
      width: width ?? size ?? 50,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radius ?? 10),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: child ??
          const Center(child: Icon(CupertinoIcons.photo, color: Colors.grey)),
    );
  }
}
