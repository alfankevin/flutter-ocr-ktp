import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

class AlternatifPage extends StatefulWidget {
  const AlternatifPage({super.key});

  @override
  State<AlternatifPage> createState() => _AlternatifPageState();
}

class _AlternatifPageState extends State<AlternatifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alternatif'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 63,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "1",
                  style: AppStyles.text14Px.copyWith(color: ColorTheme.white),
                ),
              ),
              8.horizontalSpaceRadius,
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: 16.all.copyWith(top: 0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    const Icon(Icons.add_box_outlined),
                    6.horizontalSpaceRadius,
                    const Text('Tambah'),
                  ],
                ),
              ),
            ),
            16.horizontalSpaceRadius,
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    const Text('Simpan'),
                    6.horizontalSpaceRadius,
                    const Icon(Icons.save_rounded),
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
