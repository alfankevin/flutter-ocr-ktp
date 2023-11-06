import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

class KtpScanPage extends StatefulWidget {
  const KtpScanPage({super.key});

  @override
  State<KtpScanPage> createState() => _KtpScanPageState();
}

class _KtpScanPageState extends State<KtpScanPage> {
  CameraController? controller;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    var position = _cameras!.isNotEmpty ? 1 : 0;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text("Take Picture"),
                onPressed: () {
                  controller!.takePicture().then((value) {
                    // context.route.replace(HasilUploadKtpRoute(image: value));
                  });
                },
              ),
            )
          : Container(),
    );
  }
}
