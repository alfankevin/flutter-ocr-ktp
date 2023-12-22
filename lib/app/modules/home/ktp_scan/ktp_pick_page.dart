import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/core/permission/permission.dart';
import 'package:penilaian/app/core/storage/storage_interface.dart';
import 'package:penilaian/app/core/widgets/camera_overlay/camera_overlay_widget.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/modules/home/ktp_scan/cubit/ktp_scan_cubit.dart';
import 'package:penilaian/app/routes/app_routes.dart';

class KtpPickPage extends StatefulWidget {
  const KtpPickPage({super.key});

  @override
  State<KtpPickPage> createState() => _KtpPickPageState();
}

class _KtpPickPageState extends State<KtpPickPage> {
  final KtpScanCubit bloc = Modular.get<KtpScanCubit>();
  OverlayFormat format = OverlayFormat.cardID2;
  final storage = Modular.get<StorageInterface>();

  @override
  void initState() {
    super.initState();
    pickFile();
    Modular.get<PermissionInterface>().storage();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void pickFile() async {
    final file = await storage.pickFile(
      extensions: ["jpg", "jpeg", "png"],
    );
    if (file != null) {
      bloc.scanKtp(
          file.path, CardOverlay.byFormat(format), MediaQuery.of(context));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<KtpScanCubit, KtpScanState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is KtpScanLoading) {
            context.showLoadingIndicator();
          }
          if (state is KtpScanError) {
            context.showSnackbar(
                message: "KTP not found.", error: true, isPop: true);
            Navigator.of(context).pop();
          }
          if (state is KtpScanLoaded) {
            context.hideLoading();
            Modular.to.pushReplacementNamed(
              AppRoutes.ktpResultHome,
              arguments: {
                'item': state.item,
                'key': '',
              },
            );
            // context.showSnackbar(message: "NIK ditemukan");
          }
        },
        child: const Scaffold(
          body: Scaffold(),
        ),
      ),
    );
  }
}
