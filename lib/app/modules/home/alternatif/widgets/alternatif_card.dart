import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/images/image_with_loader.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';
import 'package:penilaian/app/modules/home/alternatif/alternatif_page.dart';

import '../../../../core/widgets/button/icon_rounded_button.dart';

class AlternatifCard extends StatelessWidget {
  const AlternatifCard({
    super.key,
    required this.data,
    this.onDelete,
    this.onEdit,
  });

  final KtpModel data;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) {
        onDelete?.call();
      },
      confirmDismiss: (direction) async {
        bool delete = false;
        final snackbarController = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Yakin Ingin Hapus Kriteria ${data.name}?'),
            action: SnackBarAction(label: 'Hapus', onPressed: () => delete = true),
          ),
        );
        await snackbarController.closed;
        return delete;
      },
      background: Container(
        color: ColorTheme.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16.w),
        child: const Icon(
          Icons.delete,
          color: ColorTheme.white,
        ),
      ),
      child: SizedBox(
        height: 64.r,
        width: 1.sw,
        child: Row(
          children: [
            Container(
              height: 64.r,
              width: 44.r,
              decoration: BoxDecoration(
                color: ColorTheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "1",
                style: AppStyles.text18PxBold.copyWith(color: ColorTheme.white),
              ),
            ),
            8.horizontalSpaceRadius,
            Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  height: 64.r,
                  width: 24.r,
                  margin: const EdgeInsets.only(left: 22),
                  decoration: const BoxDecoration(color: ColorTheme.primary),
                ),
                Positioned(
                  top: 9,
                  left: 0,
                  child: ImageWithLoader(
                    imageUrl: data.photo ?? "https://picsum.photos/200/300",
                    size: 45,
                    radius: 45,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                height: 64.r,
                padding: 10.all,
                decoration: BoxDecoration(
                  color: ColorTheme.primary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name ?? "Nama",
                      style: AppStyles.text16PxBold.copyWith(color: ColorTheme.white),
                    ).expand(),
                    IconRoundedButton(
                      icon: Icons.edit_square,
                      color: ColorTheme.orangeColor,
                      onTap: onEdit,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
