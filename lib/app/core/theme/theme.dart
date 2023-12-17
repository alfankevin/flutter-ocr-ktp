import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

part 'color_theme.dart';
part 'generate_theme.dart';
part 'text_theme.dart';

final colorTheme = ThemeData(
  useMaterial3: true,
  primaryColor: ColorTheme.primary,
  secondaryHeaderColor: ColorTheme.secondary,
  textTheme: GoogleFonts.workSansTextTheme(),
  dialogTheme: DialogTheme(
    backgroundColor: ColorTheme.white,
    titleTextStyle: AppStyles.text18PxSemiBold.copyWith(
      color: ColorTheme.primary,
    ),
    contentTextStyle: AppStyles.text14Px.copyWith(
      color: ColorTheme.neutral.shade800,
    ),
  ),
  // appBarTheme: AppBarTheme(
  //   backgroundColor: ColorTheme.primary,
  //   shadowColor: ColorTheme.neutral.shade400,
  //   elevation: 0.5,
  //   foregroundColor: Colors.white,
  //   titleTextStyle: AppStyles.text18PxSemiBold.copyWith(
  //     color: Colors.white,
  //   ),
  // ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorTheme.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: 30.rounded,
      ),
      textStyle: AppStyles.text16PxMedium,
      minimumSize: Size(200.r, 48.r),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColorTheme.primary,
      backgroundColor: Colors.white,
      side: const BorderSide(color: ColorTheme.primary),
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 8.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: 30.rounded,
        side: BorderSide(
          width: 10.w,
          color: ColorTheme.primary,
          style: BorderStyle.solid,
        ),
      ),
      textStyle: AppStyles.text16PxMedium.copyWith(
        color: ColorTheme.primary,
      ),
      minimumSize: Size(200.r, 48.r),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
  scaffoldBackgroundColor: ColorTheme.white,
);
