import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract interface class TokenStorage {
  Future<void> saveAccessToken(String token);
  Future<void> saveRefreshToken(String token);

  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();

  Future<void> clearTokens();

  Future<bool> hasSession();
}

@LazySingleton(as: TokenStorage)
class TokenStorageImpl implements TokenStorage {
  TokenStorageImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  @override
  Future<void> saveAccessToken(String token) {
    return _secureStorage.write(key: _accessTokenKey, value: token);
  }

  @override
  Future<void> saveRefreshToken(String token) {
    return _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  @override
  Future<String?> getAccessToken() {
    return _secureStorage.read(key: _accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() {
    return _secureStorage.read(key: _refreshTokenKey);
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
    ]);
  }

  @override
  Future<bool> hasSession() async {
    final results = await Future.wait([getAccessToken(), getRefreshToken()]);

    return results[0] != null && results[1] != null;
  }
}
