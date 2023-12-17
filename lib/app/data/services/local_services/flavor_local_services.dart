import 'package:get_storage/get_storage.dart';

abstract class FlavorLocalServices {
  String get image;
  String get name;

  Future<void> setImage(String value);
  Future<void> setName(String value);
}

class FlavorLocalServicesImpl extends FlavorLocalServices {
  final _box = GetStorage();
  final _keyName = "flavor-name-ddddd";
  final _keyImage = "flavor-Image-ddddd";

  @override
  String get image => _box.read(_keyImage) ?? "assets/img/app-development1.png";

  @override
  String get name => _box.read(_keyName) ?? "OCR KTP";

  @override
  Future<void> setImage(String value) {
    return _box.write(_keyImage, value);
  }

  @override
  Future<void> setName(String value) {
    return _box.write(_keyName, value);
  }
}
