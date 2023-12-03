import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/blocs/session/session_cubit.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    context.read<SessionCubit>().checkSession();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listener: (context, state) {
        if (state is SessionReadyState) {
          context.to.pushReplacementNamed(AppRoutes.home);
        } else {
          context.to.pushReplacementNamed(AppRoutes.login);
        }
      },
      child: Scaffold(
        backgroundColor: ColorTheme.primary,
        body: SafeArea(
          child: Center(
            child: Image.asset(
              'assets/img/logo.png',
              width: 250.r,
            ),
          ),
        ),
      ),
    );
  }
}
