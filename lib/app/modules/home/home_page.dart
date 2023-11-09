import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import 'cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeCubit>();
  String file = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: file.isEmpty
          ? const Center(
              child: Text(
                'HomePage is working',
                style: TextStyle(fontSize: 20),
              ),
            )
          : Image.file(File(file)),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Scan KTP',
        onPressed: () async {
          final rest = await Modular.to.pushNamed(AppRoutes.KTP_SCAN);
          if (rest != null && rest is String) {
            setState(() {
              file = rest;
            });
          }
        },
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
