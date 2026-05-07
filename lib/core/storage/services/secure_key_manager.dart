import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract interface class SecureKeyManager {
  Future<List<int>> getOrCreateKey();
  Future<void> deleteKey();
  void zeroKey(List<int> key);
}

@LazySingleton(as: SecureKeyManager)
class SecureKeyManagerImpl implements SecureKeyManager {
  SecureKeyManagerImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  static const _aesKey = 'hive_aes_key';

  @override
  Future<List<int>> getOrCreateKey() async {
    final existing = await _secureStorage.read(key: _aesKey);

    if (existing != null) {
      return base64Url.decode(existing);
    }

    final freshKey = Hive.generateSecureKey();

    await _secureStorage.write(key: _aesKey, value: base64UrlEncode(freshKey));

    return freshKey;
  }

  @override
  Future<void> deleteKey() {
    return _secureStorage.delete(key: _aesKey);
  }

  @override
  void zeroKey(List<int> key) {
    for (var i = 0; i < key.length; i++) {
      key[i] = 0;
    }
  }
}
