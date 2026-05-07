import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract interface class ReinstallGuard {
  Future<void> handle();
}

@LazySingleton(as: ReinstallGuard)
class ReinstallGuardImpl implements ReinstallGuard {
  ReinstallGuardImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  static const _installSentinel = 'install_sentinel';

  @override
  Future<void> handle() async {
    if (defaultTargetPlatform != TargetPlatform.iOS) {
      return;
    }

    final sentinel = await _secureStorage.read(key: _installSentinel);

    if (sentinel == null) {
      await _secureStorage.deleteAll();

      await _secureStorage.write(key: _installSentinel, value: '1');
    }
  }
}
