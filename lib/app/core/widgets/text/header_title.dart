import 'package:flutter/material.dart';
import 'package:penilaian/app/core/theme/theme.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: CustomTextTheme.heading1.copyWith(color: ColorTheme.primary),
    );
  }
}
