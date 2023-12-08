import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/data/extensions/context_extension.dart';

// TODO We can customize this screen as per our design to show errors on debug and release mode
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.message,
    this.onTap,
  });

  final String message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 40,
            ),
            16.verticalSpacingRadius,
            Text(
              message,
              textAlign: TextAlign.center,
              style: CustomTextTheme.paragraph1.copyWith(
                color: ColorTheme.statusRed,
              ),
            ),
            8.verticalSpacingRadius,
            Text(
              "Tap to reload",
              style: CustomTextTheme.caption.copyWith(
                color: ColorTheme.textGrey,
              ),
            ),
            8.verticalSpace,
          ],
        ),
      ),
    );
  }
}
