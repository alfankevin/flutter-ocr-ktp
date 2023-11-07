import 'package:bloc/bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nik_validator/nik_validator.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';

part 'ktp_scan_state.dart';

class KtpScanCubit extends Cubit<KtpScanState> {
  final textRecognizer = TextRecognizer();

  KtpScanCubit() : super(KtpScanInitial());

  Future<void> scanKtp(String imagePath) async {
    emit(KtpScanLoading());
    final inputImage = InputImage.fromFilePath(imagePath);
    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    for (var element in recognizedText.blocks) {
      NIKModel r = await NIKValidator.instance.parse(nik: element.text);
      if (r.valid == true) {
        final ktp = KtpModel.fromScan(r);
        emit(KtpScanLoaded(ktp.copyWith(
          name: () => recognizedText.blocks[1].text,
        )));
        return;
      }
    }
    emit(KtpScanError('NIK tidak ditemukan'));
  }
}
