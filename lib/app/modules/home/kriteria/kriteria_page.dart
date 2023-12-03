import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

class KriteriaPage extends StatefulWidget {
  const KriteriaPage({super.key});

  @override
  State<KriteriaPage> createState() => _KriteriaPageState();
}

class _KriteriaPageState extends State<KriteriaPage> {
  int listKriteria = 1;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: "Kreteria",
      ),
      body: ListView.separated(
        separatorBuilder: (context, i) => 10.verticalSpacingRadius,
        itemCount: listKriteria,
        itemBuilder: (context, i) => KriteriaFormCard(
          number: i + 1,
          onChanged: (name, w) {},
        ),
      ),
      bottomNavigationBar: Padding(
        padding: 16.all.copyWith(top: 0),
        child: Row(
          children: [
            12.horizontalSpaceRadius,
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      bottomLeft: Radius.circular(16.r),
                    ),
                  ),
                  textStyle: AppStyles.text16PxMedium,
                  minimumSize: Size(200.r, 48.r),
                ),
                onPressed: () {
                  setState(() {
                    listKriteria++;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_box_outlined),
                    6.horizontalSpaceRadius,
                    const Text('Tambah'),
                  ],
                ),
              ),
            ),
            12.horizontalSpaceRadius,
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                  ),
                  textStyle: AppStyles.text16PxMedium,
                  minimumSize: Size(200.r, 48.r),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Simpan'),
                    6.horizontalSpaceRadius,
                    const Icon(Icons.save_rounded),
                  ],
                ),
              ),
            ),
            12.horizontalSpaceRadius,
          ],
        ),
      ),
    );
  }
}

class KriteriaFormCard extends StatelessWidget {
  KriteriaFormCard({
    super.key,
    required this.number,
    required this.onChanged,
  });

  final int number;
  final Function(String name, String w) onChanged;

  final nameCont = TextEditingController();
  final wCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48.r,
          width: 44.r,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            "$number",
            style: AppStyles.text14Px.copyWith(color: ColorTheme.white),
          ),
        ),
        10.horizontalSpaceRadius,
        TextField(
          decoration: GenerateTheme.inputDecoration("Nama Kriteria"),
          style: AppStyles.text16Px.copyWith(color: ColorTheme.black),
          controller: nameCont,
        ).expand(),
        10.horizontalSpaceRadius,
        SizedBox(
          width: 65,
          child: TextField(
            controller: wCont,
            decoration: GenerateTheme.inputDecoration("W"),
            keyboardType: TextInputType.number,
            style: AppStyles.text16Px.copyWith(color: ColorTheme.black),
            onChanged: (_) {
              if (wCont.text.isNotEmpty) {
                final clear = wCont.text.replaceAll(RegExp(r'[^0-9]'), '');
                wCont.text = clear;
              }
            },
            onSubmitted: (value) {
              if (wCont.text.isNotEmpty && nameCont.text.isNotEmpty) {
                final clear = wCont.text.replaceAll(RegExp(r'[^0-9]'), '');
                wCont.text = clear;
                onChanged(nameCont.text, clear);
              }
            },
          ),
        ),
      ],
    );
  }
}
