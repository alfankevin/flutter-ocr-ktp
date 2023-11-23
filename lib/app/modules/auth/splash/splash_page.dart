import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));
    Modular.to.pushReplacementNamed(AppRoutes.LOGIN);
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primary,
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/img/logo-awal.jpg'),
        ),
      ),
    );
  }
}
