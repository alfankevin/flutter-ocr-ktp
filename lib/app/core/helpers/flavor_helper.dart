abstract class FlavorHelper {
  String get image;
  String get name;
}

class FlavorBisa extends FlavorHelper {
  @override
  String get image => "assets/img/logo.png";

  @override
  String get name => "Tentu Bisa";
}

class FlavorTentu extends FlavorHelper {
  @override
  String get image => "assets/img/app-development1.png";

  @override
  String get name => "OCR KTP";
}
