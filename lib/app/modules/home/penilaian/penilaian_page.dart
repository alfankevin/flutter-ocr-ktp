import 'package:flutter/material.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';

class PenilaianPage extends StatefulWidget {
  const PenilaianPage({super.key});

  @override
  State<PenilaianPage> createState() => _PenilaianPageState();
}

class _PenilaianPageState extends State<PenilaianPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'Penilaian',
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
