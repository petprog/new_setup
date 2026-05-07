import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract interface class HiveStorageEngine {
  Future<void> init(List<int> encryptionKey);

  Future<void> put({required String key, required dynamic value});

  dynamic get(String key);

  Future<void> delete(String key);

  Future<void> clear();
}

@LazySingleton(as: HiveStorageEngine)
class HiveStorageEngineImpl implements HiveStorageEngine {
  static const _boxName = 'device_box';

  Box? _box;

  @override
  Future<void> init(List<int> encryptionKey) async {
    _box = await Hive.openBox(
      _boxName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  @override
  Future<void> put({required String key, required dynamic value}) {
    return _box!.put(key, value);
  }

  @override
  dynamic get(String key) {
    return _box!.get(key);
  }

  @override
  Future<void> delete(String key) {
    return _box!.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box?.close();
    await Hive.deleteBoxFromDisk(_boxName);
  }
}
