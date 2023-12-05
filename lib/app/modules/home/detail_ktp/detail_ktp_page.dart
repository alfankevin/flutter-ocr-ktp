import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/helpers/string_helper.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/images/image_with_loader.dart';
import 'package:penilaian/app/core/widgets/text/warning_text.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';
import 'package:penilaian/app/data/services/local_services/selected_local_services.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import 'widgets/text_result_card.dart';

class DetailKtpPage extends StatefulWidget {
  const DetailKtpPage({
    super.key,
    required this.nikResult,
  });

  final KtpModel nikResult;

  @override
  State<DetailKtpPage> createState() => _DetailKtpPageState();
}

class _DetailKtpPageState extends State<DetailKtpPage> {
  final storageRef = FirebaseStorage.instance.ref(StringHelper.imageStorage);
  late final DatabaseReference _alternatifRef;
  final local = Modular.get<SelectedLocalServices>();
  late final String _refKey;
  late KtpModel model;

  @override
  void initState() {
    super.initState();
    _refKey = local.selected;
    model = widget.nikResult;
    _alternatifRef = FirebaseDatabase.instance.ref('$_refKey/alternatif');
  }

  Future<void> kirim() async {
    context.showLoadingIndicator();
    final filePath = widget.nikResult.photo!;
    final file = File(filePath);
    String key = 16.generateRandomString;
    if (local.selectedEdit.isNotEmpty) {
      key = local.selectedEdit;
    }

    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

    // Upload file and metadata to the path 'images/mountains.jpg'
    final uploadTask = storageRef.child("$key.jpg");

    try {
      final hasil = await uploadTask.putFile(file, metadata);
      final url = await hasil.ref.getDownloadURL();

      model = model.copyWith(photo: () => url);
      await _alternatifRef.child(key).set(model.toMap());
      await local.removeSelectedEdit();
    } on firebase_core.FirebaseException catch (e) {
      context.showSnackbar(
          message: e.message ?? "Terjadi kesalahan", error: true, isPop: true);
    } finally {
      Modular.to.popUntil((p0) => p0.settings.name == AppRoutes.alternatifHome);
      context.showSnackbar(message: "Berhasil Membuat Alternatif!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail KTP'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            16.verticalSpacingRadius,
            const WarningText(
              text: "Klik pada bagian yang ingin diubah!",
            ).px(16),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.nikResult.photo != null)
                    Center(
                      child: widget.nikResult.photo!.contains('firebase')
                          ? ImageWithLoader(
                              imageUrl: widget.nikResult.photo!,
                              size: 200,
                            )
                          : Image.file(
                              File(widget.nikResult.photo!),
                            ),
                    ),
                  16.verticalSpacingRadius,
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "NIK",
                    value: widget.nikResult.nik!,
                    onChanged: (x) {
                      model = model.copyWith(nik: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Nama",
                    value: widget.nikResult.name!,
                    onChanged: (x) {
                      model = model.copyWith(name: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Kode Unik",
                    value: widget.nikResult.uniqueCode!,
                    onChanged: (x) {
                      model = model.copyWith(uniqueCode: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Jenis Kelamin",
                    value: widget.nikResult.gender!,
                    onChanged: (x) {
                      model = model.copyWith(gender: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Tanggal Lahir",
                    value: widget.nikResult.bornDate!,
                    onChanged: (x) {
                      model = model.copyWith(bornDate: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Usia",
                    value: widget.nikResult.age!,
                    onChanged: (x) {
                      model = model.copyWith(age: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Ulang Tahun",
                    value: widget.nikResult.nextBirthday!,
                    onChanged: (x) {
                      model = model.copyWith(nextBirthday: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Zodiak",
                    value: widget.nikResult.zodiac!,
                    onChanged: (x) {
                      model = model.copyWith(zodiac: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Provinsi",
                    value: widget.nikResult.province!,
                    onChanged: (x) {
                      model = model.copyWith(province: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Kota/Kabupaten",
                    value: widget.nikResult.city!,
                    onChanged: (x) {
                      model = model.copyWith(city: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Kecamatan",
                    value: widget.nikResult.subdistrict!,
                    onChanged: (x) {
                      model = model.copyWith(subdistrict: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.black),
                  TextResultCard(
                    title: "Kode Pos",
                    value: widget.nikResult.postalCode!,
                    onChanged: (x) {
                      model = model.copyWith(postalCode: () => x);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            16.verticalSpacingRadius,
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorTheme.red,
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
                      Modular.to.pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.replay_rounded),
                        6.horizontalSpaceRadius,
                        const Text('Ulangi'),
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
                    onPressed: () {
                      kirim();
                    },
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
              ],
            ).px(16),
            16.verticalSpacingRadius,
          ],
        ),
      ),
    );
  }
}
