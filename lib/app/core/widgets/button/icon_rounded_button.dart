import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

class IconRoundedButton extends StatelessWidget {
  const IconRoundedButton({
    super.key,
    required this.icon,
    this.onTap,
    required this.color,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: color,
          borderRadius: 8.rounded,
        ),
        child: Icon(
          icon,
          color: ColorTheme.white,
          size: 24.r,
        ),
      ),
    );
  }
}
