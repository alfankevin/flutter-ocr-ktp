import 'package:bloc/bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nik_validator/nik_validator.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';

part 'ktp_scan_state.dart';

class KtpScanCubit extends Cubit<KtpScanState> {
  KtpScanCubit() : super(KtpScanInitial());

  Future<void> scanKtp(String imagePath) async {
    emit(KtpScanLoading());
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFilePath(imagePath);
    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    final List<String> dataText = [];
    for (var item in recognizedText.blocks) {
      for (var line in item.lines) {
        dataText.add(line.text.replaceAll(':', '').trim());
      }
    }

    for (var i = 0; i < dataText.length; i++) {
      print("--> ${dataText[i]} <--");
      NIKModel r = await NIKValidator.instance.parse(nik: dataText[i]);
      textRecognizer.close();
      if (r.valid == true) {
        final ktp = KtpModel.fromScan(r);
        String name = dataText[i + 1].replaceAll(':', '');
        emit(KtpScanLoaded(ktp.copyWith(name: () => name)));
        return;
      }
    }

    emit(KtpScanError('NIK tidak ditemukan'));
  }
}
