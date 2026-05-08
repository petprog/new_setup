import 'package:injectable/injectable.dart';
import 'package:new_setup/core/core.dart';

@module
abstract class StorageModule {
  @preResolve
  @singleton
  Future<Storage> storage(
    TokenStorage tokenStorage,
    SecureKeyManager keyManager,
    HiveStorageEngine hiveEngine,
    ReinstallGuard reinstallGuard,
  ) async {
    final impl = StorageImpl(
      tokenStorage,
      keyManager,
      hiveEngine,
      reinstallGuard,
    );
    await impl.initStorage();
    return impl;
  }
}
