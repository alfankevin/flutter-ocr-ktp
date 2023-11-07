import 'package:flutter/material.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';

class DetailKtpPage extends StatelessWidget {
  const DetailKtpPage({
    Key? key,
    required this.nikResult,
  }) : super(key: key);

  final KtpModel nikResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail KTP'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: context.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textWidgeT(title: "NIK", value: nikResult.nik!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Nama", value: nikResult.name!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Kode Unik", value: nikResult.uniqueCode!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Jenis Kelamin", value: nikResult.gender!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Tanggal Lahir", value: nikResult.bornDate!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Usia", value: nikResult.age!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Ulang Tahun", value: nikResult.nextBirthday!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Zodiak", value: nikResult.zodiac!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Provinsi", value: nikResult.province!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Kota/Kabupaten", value: nikResult.city!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Kecamatan", value: nikResult.subdistrict!),
                  const Divider(color: Colors.black),
                  _textWidgeT(title: "Kode Pos", value: nikResult.postalCode!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textWidgeT({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        )
      ],
    );
  }
}
