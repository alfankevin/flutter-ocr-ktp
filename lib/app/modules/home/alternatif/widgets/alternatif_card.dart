import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/images/image_with_loader.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';

import '../../../../core/widgets/button/icon_rounded_button.dart';

class AlternatifCard extends StatelessWidget {
  const AlternatifCard({
    super.key,
    required this.data,
    required this.number,
    this.onDelete,
    this.onEdit,
    this.onTap,
  });

  final KtpModel data;
  final int number;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;

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
            content: Text('Delete Data ${data.name}?'),
            action: SnackBarAction(label: 'Delete', onPressed: () => delete = true),
          ),
        );
        await snackbarController.closed;
        return delete;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.delete,
          color: ColorTheme.white,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffDDDBFF).withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffDDDBFF).withOpacity(1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(2, 3)
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/img/image4.png',
                        fit: BoxFit.cover,
                        width: 45,
                        height: 60,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.name ?? "-",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey
                                )
                              ),
                              Text(
                                '1 page',
                                style: TextStyle(
                                  fontSize: 14,
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ),
          ),
        ]
      ),
    );
  }
}
