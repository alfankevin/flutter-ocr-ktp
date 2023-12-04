import 'package:get_storage/get_storage.dart';

abstract class SelectedLocalServices {
  String get selected;
  String get selectedEdit;
  Future<void> setSelected(String value);
  Future<void> setSelectedEdit(String value);
  Future<void> removeSelected();
  Future<void> removeSelectedEdit();
}

class SelectedLocalServicesImpl implements SelectedLocalServices {
  final GetStorage _box = GetStorage();
  final String _key = 'selected-kflamkemivae';
  final String _keyEdit = 'selected-edddd-kflamkemivae';

  SelectedLocalServicesImpl();

  @override
  String get selected => _box.read(_key) ?? '';

  @override
  Future<void> removeSelected() async {
    await _box.remove(_key);
  }

  @override
  Future<void> setSelected(String value) => _box.write(_key, value);

  @override
  Future<void> removeSelectedEdit() => _box.remove(_keyEdit);

  @override
  String get selectedEdit => _box.read(_keyEdit) ?? '';

  @override
  Future<void> setSelectedEdit(String value) => _box.write(_keyEdit, value);
}
