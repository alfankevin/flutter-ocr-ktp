import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:nik_validator/nik_validator.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';

part 'ktp_scan_state.dart';

class KtpScanCubit extends Cubit<KtpScanState> {
  KtpScanCubit() : super(KtpScanInitial());

  Future<String> getStorage(String name) async {
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/photo/';
    if (!Directory(path).existsSync()) {
      Directory(path).createSync(recursive: true);
    }
    return path + name;
  }

  Future<void> scanKtp(String imagePath) async {
    emit(KtpScanLoading());
    String savePath = await getStorage(path.basename(imagePath));
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
      ),
    );

    final inputImage = InputImage.fromFilePath(imagePath);

    final faces = await faceDetector.processImage(inputImage);
    if (faces.isNotEmpty) {
      final face = faces.first.boundingBox;
      img.Command cmd = img.Command()
        ..decodeImageFile(imagePath)
        ..copyCrop(
            x: face.left.toInt(),
            y: face.top.toInt(),
            width: face.width.toInt(),
            height: face.height.toInt())
        ..writeToFile(savePath);

      await cmd.executeThread();
    }

    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    final List<String> dataText = [];
    for (var item in recognizedText.blocks) {
      for (var line in item.lines) {
        dataText.add(line.text.replaceAll(':', '').trim());
      }
    }

    for (var i = 0; i < dataText.length; i++) {
      // print("--> ${dataText[i]} <--");
      NIKModel r = await NIKValidator.instance.parse(nik: dataText[i]);
      textRecognizer.close();
      if (r.valid == true) {
        final ktp = KtpModel.fromScan(r);
        String name = dataText[i + 1].replaceAll(':', '');
        emit(KtpScanLoaded(ktp.copyWith(name: () => name, photo: () => savePath)));
        return;
      }
    }

    emit(KtpScanError('NIK tidak ditemukan'));
  }
}
