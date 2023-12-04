import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/widgets/button/custom_back_button.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    super.key,
    required this.title,
    this.actions,
    this.isBack = true,
  });

  final String title;
  final List<Widget>? actions;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBack ? const CustomBackButton() : null,
      leadingWidth: 70.r,
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.r);
}
