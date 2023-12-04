import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

class WarningText extends StatelessWidget {
  const WarningText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: 6.all,
      decoration: BoxDecoration(
        color: ColorTheme.statusOrange.withOpacity(0.15),
        borderRadius: 4.rounded,
      ),
      child: Text(
        text,
        style: AppStyles.text12PxMedium.copyWith(
          color: ColorTheme.statusOrange,
        ),
      ),
    );
  }
}
