import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
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
import 'package:penilaian/app/core/config/app_asset.dart';

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
  late final CollectionReference _alternatifRef;
  final local = Modular.get<SelectedLocalServices>();
  late final String _refKey;
  late KtpModel model;

  @override
  void initState() {
    super.initState();
    _refKey = local.selected;
    model = widget.nikResult;
    _alternatifRef = FirebaseFirestore.instance.collection('$_refKey/alternatif');
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
      if (!filePath.contains('firebasestorage.googleapis.com')) {
        final hasil = await uploadTask.putFile(file, metadata);
        final url = await hasil.ref.getDownloadURL();
        model = model.copyWith(photo: () => url);
      }

      await _alternatifRef.doc(key).set(model.toMap());
      await local.removeSelectedEdit();
      Modular.to.popUntil((p0) => p0.settings.name == AppRoutes.alternatifHome);
      // context.showSnackbar(message: "Berhasil Membuat Alternatif!");
    } on firebase_core.FirebaseException catch (e) {
      // context.showSnackbar(message: e.message ?? "Terjadi kesalahan", error: true, isPop: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Image.asset(
                'assets/img/print.png',
                height: 24,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: context.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.nikResult.photo != null)
                    Center(
                      child: widget.nikResult.photo!.contains('firebase')
                          ? ImageWithLoader(
                              imageUrl: widget.nikResult.photo!,
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(widget.nikResult.photo!),
                            ),
                    ),
                  30.verticalSpacingRadius,
                  TextResultCard(
                    title: "NIK",
                    value: widget.nikResult.nik!,
                    onChanged: (x) {
                      model = model.copyWith(nik: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  5.verticalSpacingRadius,
                  TextResultCard(
                    title: "Nama",
                    value: widget.nikResult.name!,
                    onChanged: (x) {
                      model = model.copyWith(name: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  5.verticalSpacingRadius,
                  TextResultCard(
                    title: "Tanggal Lahir",
                    value: widget.nikResult.bornDate!,
                    onChanged: (x) {
                      model = model.copyWith(bornDate: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  5.verticalSpacingRadius,
                  TextResultCard(
                    title: "Usia",
                    value: widget.nikResult.age!,
                    onChanged: (x) {
                      model = model.copyWith(age: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  5.verticalSpacingRadius,
                  TextResultCard(
                    title: "Jenis Kelamin",
                    value: widget.nikResult.gender!,
                    onChanged: (x) {
                      model = model.copyWith(gender: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  5.verticalSpacingRadius,
                  TextResultCard(
                    title: "Gol Darah",
                    value: '-',
                    onChanged: (x) {
                      model = model.copyWith(uniqueCode: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  5.verticalSpacingRadius,
                  TextResultCard(
                    title: "Provinsi",
                    value: widget.nikResult.province!,
                    onChanged: (x) {
                      model = model.copyWith(province: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  5.verticalSpacingRadius,
                  TextResultCard(
                    title: "Kota/Kabupaten",
                    value: widget.nikResult.city!,
                    onChanged: (x) {
                      model = model.copyWith(city: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  5.verticalSpacingRadius,
                  TextResultCard(
                    title: "Kecamatan",
                    value: widget.nikResult.subdistrict!,
                    onChanged: (x) {
                      model = model.copyWith(subdistrict: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  5.verticalSpacingRadius,
                  TextResultCard(
                    title: "Kode Pos",
                    value: widget.nikResult.postalCode!,
                    onChanged: (x) {
                      model = model.copyWith(postalCode: () => x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFDDDBFF),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (index == 0) {
              Modular.to.pop();
            } else if (index == 1) {
              kirim();
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back_rounded),
              label: 'Cancel',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_rounded),
              label: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}
