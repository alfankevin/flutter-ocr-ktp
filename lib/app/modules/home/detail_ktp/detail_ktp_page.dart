import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/widgets/images/image_with_loader.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/ktm_model.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import 'widgets/text_result_card.dart';

class DetailKtpPage extends StatefulWidget {
  const DetailKtpPage({
    super.key,
    required this.nikResult,
    required this.docKey,
  });

  final KtmModel nikResult;
  final String docKey;

  @override
  State<DetailKtpPage> createState() => _DetailKtpPageState();
}

class _DetailKtpPageState extends State<DetailKtpPage> {
  late final CollectionReference _alternatifRef;

  late KtmModel model;

  @override
  void initState() {
    super.initState();
    model = widget.nikResult;
    _alternatifRef = FirebaseFirestore.instance.collection('scan');
  }

  Future<void> kirim() async {
    context.showLoadingIndicator();
    String key =
        widget.docKey.isEmpty ? 16.generateRandomString : widget.docKey;

    try {
      await _alternatifRef.doc(key).set(model.toJson());
      Modular.to.popUntil((p0) => p0.settings.name == AppRoutes.alternatifHome);
      // context.showSnackbar(message: "Berhasil Membuat Alternatif!");
    } on firebase_core.FirebaseException catch (e) {
      context.showSnackbar(
          message: e.message ?? "An error has occurred.",
          error: true,
          isPop: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 15),
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
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
                  Center(
                    child: ImageWithLoader(
                      imageUrl: widget.nikResult.foto,
                      width: 150,
                      size: 150,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  30.verticalSpacingRadius,
                  TextResultCard(
                    title: "NIM",
                    value: widget.nikResult.nim,
                    onChanged: (x) {
                      model = model.copyWith(nim: x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  10.verticalSpacingRadius,
                  TextResultCard(
                    title: "Nama",
                    value: widget.nikResult.nama,
                    onChanged: (x) {
                      model = model.copyWith(nama: x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  10.verticalSpacingRadius,
                  TextResultCard(
                    title: "TTL",
                    value: widget.nikResult.lahir,
                    onChanged: (x) {
                      model = model.copyWith(lahir: x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  10.verticalSpacingRadius,
                  TextResultCard(
                    title: "Jurusan",
                    value: widget.nikResult.prodi,
                    onChanged: (x) {
                      model = model.copyWith(prodi: x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  10.verticalSpacingRadius,
                  TextResultCard(
                    title: "Alamat",
                    value: widget.nikResult.dusun,
                    onChanged: (x) {
                      model = model.copyWith(dusun: x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  10.verticalSpacingRadius,
                  TextResultCard(
                    title: "Dusun",
                    value: widget.nikResult.jalan,
                    onChanged: (x) {
                      model = model.copyWith(jalan: x);
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.grey),
                  10.verticalSpacingRadius,
                  TextResultCard(
                    title: "Kota/Kabupaten",
                    value: widget.nikResult.kota,
                    onChanged: (x) {
                      model = model.copyWith(kota: x);
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
          backgroundColor: const Color(0xFFDDDBFF),
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
