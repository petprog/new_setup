import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:new_setup/core/core.dart';

@lazySingleton
class SecureStorageHelper {
  static const _secureStorage = FlutterSecureStorage();

  Future<void> saveAccessToken(String accessToken) async {
    try {
      await _secureStorage.write(key: AppKeys.accessToken, value: accessToken);
    } catch (_) {}
  }

  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: AppKeys.accessToken);
    } on PlatformException catch (e) {
      debugPrint('getAccessToken failed: $e');
      await _secureStorage.delete(key: AppKeys.accessToken);
      return null;
    }
  }

  Future<void> clearAccessToken() async {
    try {
      await _secureStorage.delete(key: AppKeys.accessToken);
    } catch (_) {}
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _secureStorage.write(
        key: AppKeys.refreshToken,
        value: refreshToken,
      );
    } catch (_) {}
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: AppKeys.refreshToken);
    } on PlatformException catch (e) {
      debugPrint('getSecureToken failed: $e');
      await _secureStorage.delete(key: AppKeys.refreshToken);
      return null;
    }
  }

  Future<void> clearRefreshToken() async {
    try {
      await _secureStorage.delete(key: AppKeys.refreshToken);
    } catch (_) {}
  }

  Future<void> clear() async {
    try {
      await _secureStorage.delete(key: AppKeys.accessToken);
      await _secureStorage.delete(key: AppKeys.refreshToken);
      await _secureStorage.delete(key: AppKeys.sessionToken);
      await _secureStorage.delete(key: AppKeys.sessionTokenDuration);
    } catch (_) {
      // optionally log the error
    }
  }

  Future<void> saveSessionToken(String sessionToken) async {
    try {
      await _secureStorage.write(
        key: AppKeys.sessionToken,
        value: sessionToken,
      );
    } catch (_) {}
  }

  Future<String?> getSessionToken() async {
    try {
      return _secureStorage.read(key: AppKeys.sessionToken);
    } on PlatformException catch (_) {
      await _secureStorage.delete(key: AppKeys.sessionToken);
      return null;
    }
  }

  Future<void> clearSessionToken() async {
    try {
      await _secureStorage.delete(key: AppKeys.sessionToken);
    } catch (_) {}
  }

  Future<void> saveSessionDuration(int sessionDuration) async {
    try {
      await _secureStorage.write(
        key: AppKeys.sessionTokenDuration,
        value: sessionDuration.toString(),
      );
    } catch (_) {}
  }

  Future<String?> getSessionDuration() async {
    try {
      return _secureStorage.read(key: AppKeys.sessionTokenDuration);
    } on PlatformException catch (_) {
      await _secureStorage.delete(key: AppKeys.sessionTokenDuration);
      return null;
    }
  }

  Future<void> clearSessionDuration() async {
    try {
      await _secureStorage.delete(key: AppKeys.sessionTokenDuration);
    } catch (_) {}
  }
}
