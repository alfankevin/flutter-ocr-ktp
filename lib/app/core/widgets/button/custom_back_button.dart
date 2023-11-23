import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/core/theme/theme.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Modular.to.pop();
      },
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        size: 18,
        color: ColorTheme.neutral[500],
      ),
    );
  }
}
