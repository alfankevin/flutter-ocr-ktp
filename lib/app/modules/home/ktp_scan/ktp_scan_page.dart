import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/modules/home/ktp_scan/cubit/ktp_scan_cubit.dart';
import 'package:penilaian/app/routes/app_routes.dart';

class KtpScanPage extends StatefulWidget {
  const KtpScanPage({super.key});

  @override
  State<KtpScanPage> createState() => _KtpScanPageState();
}

class _KtpScanPageState extends State<KtpScanPage> {
  CameraController? controller;
  List<CameraDescription>? _cameras;
  final KtpScanCubit bloc = Modular.get<KtpScanCubit>();

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    print("Haloo => ${_cameras!.length}");
    var position = _cameras!.isNotEmpty ? 0 : 0;
    controller = CameraController(
      _cameras![position],
      ResolutionPreset.max,
      enableAudio: false,
    );
    controller!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    bloc.textRecognizer.close();
    bloc.close();
    super.dispose();
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
            context.showSnackbar(message: "NIK ditemukan", error: true, isPop: true);
            controller?.resumePreview();
          }
          if (state is KtpScanLoaded) {
            context.hideLoading();
            Modular.to.pushNamed(AppRoutes.KTP_RESULT, arguments: state.item);
            context.showSnackbar(message: "NIK ditemukan");
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: controller != null
                    ? CameraPreview(controller!)
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(color: Colors.black87),
                      ),
              ),
              Positioned(
                left: 32,
                top: 0,
                bottom: 50,
                right: 32,
                child: Center(
                  child: Container(
                    width: context.width * .85,
                    height: context.width * 1.1,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: controller != null
              ? Container(
                  width: double.infinity,
                  padding: 24.all,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: ElevatedButton(
                    child: const Text("Take Picture"),
                    onPressed: () {
                      controller!.takePicture().then((value) {
                        controller!.pausePreview();
                        bloc.scanKtp(value.path);
                      });
                    },
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
