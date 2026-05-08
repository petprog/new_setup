import 'services/services.dart';

abstract interface class Storage {
  Future<void> initStorage();

  Future<void> saveToken({required String token});

  Future<String?> getToken();

  Future<void> saveRefreshToken({required String refreshToken});

  Future<String?> getRefreshToken();

  Future<bool> hasSession();

  Future<void> storeData({required String key, required dynamic value});

  Future<dynamic> getData({required String key});

  Future<void> removeData({required String key});

  Future<void> clearStorage();
}

class StorageImpl implements Storage {
  StorageImpl(
    this._tokenStorage,
    this._keyManager,
    this._hiveEngine,
    this._reinstallGuard,
  );

  final TokenStorage _tokenStorage;
  final SecureKeyManager _keyManager;
  final HiveStorageEngine _hiveEngine;
  final ReinstallGuard _reinstallGuard;

  List<int>? _memoryKey;

  @override
  Future<void> initStorage() async {
    await _reinstallGuard.handle();

    _memoryKey = await _keyManager.getOrCreateKey();

    await _hiveEngine.init(_memoryKey!);
  }

  @override
  Future<void> saveToken({required String token}) {
    return _tokenStorage.saveAccessToken(token);
  }

  @override
  Future<String?> getToken() {
    return _tokenStorage.getAccessToken();
  }

  @override
  Future<void> saveRefreshToken({required String refreshToken}) {
    return _tokenStorage.saveRefreshToken(refreshToken);
  }

  @override
  Future<String?> getRefreshToken() {
    return _tokenStorage.getRefreshToken();
  }

  @override
  Future<bool> hasSession() {
    return _tokenStorage.hasSession();
  }

  @override
  Future<void> storeData({required String key, required dynamic value}) {
    return _hiveEngine.put(key: key, value: value);
  }

  @override
  Future<dynamic> getData({required String key}) async {
    return _hiveEngine.get(key);
  }

  @override
  Future<void> removeData({required String key}) {
    return _hiveEngine.delete(key);
  }

  @override
  Future<void> clearStorage() async {
    await Future.wait([
      _tokenStorage.clearTokens(),
      _keyManager.deleteKey(),
      _hiveEngine.clear(),
    ]);

    if (_memoryKey != null) {
      _keyManager.zeroKey(_memoryKey!);
      _memoryKey = null;
    }
  }
}
