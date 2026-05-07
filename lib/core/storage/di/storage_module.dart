import 'package:injectable/injectable.dart';
import 'package:new_setup/core/core.dart';

@module
abstract class StorageModule {
  @preResolve
  @lazySingleton
  Future<Storage> storage(StorageImpl impl) async {
    await impl.initStorage();
    return impl;
  }
}
