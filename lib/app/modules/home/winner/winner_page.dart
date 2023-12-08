import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:penilaian/app/core/helpers/pdf_helper.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/app_error_widget.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/core/widgets/images/image_with_loader.dart';
import 'package:penilaian/app/core/widgets/text/no_found_widget.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/data_model.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';
import 'package:penilaian/app/data/services/local_services/selected_local_services.dart';
import 'package:share_plus/share_plus.dart';

class WinnerPage extends StatefulWidget {
  const WinnerPage({super.key});

  @override
  State<WinnerPage> createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  late final DatabaseReference _alternatifRef;
  late final DatabaseReference _dataRef;
  late String _refKey;

  @override
  void initState() {
    super.initState();
    _refKey = Modular.get<SelectedLocalServices>().selected;
    _alternatifRef = FirebaseDatabase.instance.ref('$_refKey/alternatif');
    _dataRef = FirebaseDatabase.instance.ref(_refKey);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Hasil',
      ),
      body: FutureBuilder(
        future: _alternatifRef.once(),
        builder: (context, snapshot) {
          // final data = KtpModel.fromMap(snapshot.value as Map<Object?, Object?>);
          if (!snapshot.hasData) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.data!.snapshot.exists) {
            return const NoFoundWidget();
          }
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: snapshot.error.toString(),
              onTap: () => Modular.to.pop(),
            );
          }
          final stream = snapshot.data?.snapshot.value as Map<Object?, dynamic>;
          final data = stream.values.map((e) => KtpModel.fromMap(e)).toList();
          data.sort((a, b) => b.nilai.compareTo(a.nilai));
          return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (context, index) => 12.verticalSpacingRadius,
            itemBuilder: (context, i) {
              return SizedBox(
                height: 75.r,
                width: 1.sw,
                child: Row(
                  children: [
                    Container(
                      height: 75.r,
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
                        (i + 1).toString(),
                        style: AppStyles.text18PxBold.copyWith(color: ColorTheme.white),
                      ),
                    ),
                    8.horizontalSpaceRadius,
                    Stack(
                      fit: StackFit.loose,
                      children: [
                        Container(
                          height: 75.r,
                          width: 24.r,
                          margin: EdgeInsets.only(left: 22.r),
                          decoration: const BoxDecoration(color: ColorTheme.primary),
                        ),
                        Positioned(
                          top: 9.r,
                          left: 0,
                          child: ImageWithLoader(
                            imageUrl: data[i].photo ?? "https://picsum.photos/200/300",
                            size: 45.r,
                            radius: 45.r,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        height: 75.r,
                        padding: 10.all,
                        decoration: const BoxDecoration(
                          color: ColorTheme.primary,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  data[i].name ?? "-",
                                  style: AppStyles.text16PxBold.copyWith(color: ColorTheme.white),
                                ).expand(),
                                Text.rich(
                                  TextSpan(
                                    text: "Nilai: ",
                                    children: [
                                      TextSpan(
                                        text: data[i].nilai.toString(),
                                        style: AppStyles.text14PxBold.copyWith(
                                          color: ColorTheme.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  style: AppStyles.text14PxMedium.copyWith(color: ColorTheme.white),
                                )
                              ],
                            ).expand(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: 16.all.copyWith(top: 0),
        child: ElevatedButton(
          onPressed: () {
            _dataRef.once().then((value) async {
              final data = value.snapshot.value as Map<Object?, dynamic>;
              final model = DataModel.fromMap(data);
              print(data['alternatif'].values);
              final List<KtpModel> list = [];
              for (var e in data["alternatif"].values) {
                list.add(KtpModel.fromMap(e as Map<Object?, Object?>));
              }
              list.sort((a, b) => b.nilai.compareTo(a.nilai));
              // print(list);
              final bytes = await PdfHelper.generateDocument(PdfPageFormat.a4, model, list);
              final appDocPath = (await getApplicationDocumentsDirectory()).path;
              final file = File('$appDocPath/document-${12.generateRandomString}.pdf');
              print('Save as file ${file.path} ...');
              await file.writeAsBytes(bytes);
              final rest = await Share.shareXFiles([XFile(file.path)], text: 'Simpan PDF');
              if (rest.status == ShareResultStatus.dismissed) {
                // await OpenFile.open(file.path);
                await OpenFilex.open(file.path);
              }
            });
            // PdfHelper.generateDocument(PdfPageFormat.a4, data);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.print),
              6.horizontalSpaceRadius,
              Text(
                "Unduh PDF",
                style: AppStyles.text16PxBold.copyWith(color: ColorTheme.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
