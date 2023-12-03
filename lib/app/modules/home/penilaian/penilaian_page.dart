import 'package:flutter/material.dart';

class PenilaianPage extends StatefulWidget {
  const PenilaianPage({super.key});

  @override
  State<PenilaianPage> createState() => _PenilaianPageState();
}

class _PenilaianPageState extends State<PenilaianPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penilaian'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PenilaianPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
