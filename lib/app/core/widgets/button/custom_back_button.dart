import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.r, top: 6.r, bottom: 6.r, right: 6.r),
      child: IconButton(
        style: IconButton.styleFrom(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: 30.rounded,
          ),
          padding: EdgeInsets.all(5.r),
          backgroundColor: Colors.white,
          foregroundColor: ColorTheme.primary,
        ),
        onPressed: () {
          Modular.to.pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
        ),
      ),
    );
  }
}
