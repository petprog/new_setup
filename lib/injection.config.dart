// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/core.dart' as _i446;
import 'core/storage/di/secure_module.dart' as _i858;
import 'core/storage/di/storage_module.dart' as _i790;
import 'core/storage/secure_storage.dart' as _i682;
import 'core/storage/services/hive_storage_engine.dart' as _i851;
import 'core/storage/services/reinstall_guard.dart' as _i476;
import 'core/storage/services/secure_key_manager.dart' as _i609;
import 'core/storage/services/token_storage.dart' as _i1062;
import 'network/api_handler.dart' as _i249;
import 'network/di/network_module.dart' as _i823;
import 'network/http_service.dart' as _i812;
import 'network/network.dart' as _i1010;
import 'providers/login_provider.dart' as _i201;
import 'repositories/auth_repository.dart' as _i665;
import 'repositories/repositories.dart' as _i651;
import 'usecases/login_usecase.dart' as _i178;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final securityModule = _$SecurityModule();
    final networkModule = _$NetworkModule();
    final storageModule = _$StorageModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => securityModule.secureStorage(),
    );
    gh.lazySingleton<_i682.SecureStorageHelper>(
      () => _i682.SecureStorageHelper(),
    );
    gh.lazySingleton<_i851.HiveStorageEngine>(
      () => _i851.HiveStorageEngineImpl(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i682.SecureStorageHelper>()),
    );
    gh.lazySingleton<_i1062.TokenStorage>(
      () => _i1062.TokenStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i609.SecureKeyManager>(
      () => _i609.SecureKeyManagerImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i476.ReinstallGuard>(
      () => _i476.ReinstallGuardImpl(gh<_i558.FlutterSecureStorage>()),
    );
    await gh.singletonAsync<_i446.Storage>(
      () => storageModule.storage(
        gh<_i446.TokenStorage>(),
        gh<_i446.SecureKeyManager>(),
        gh<_i446.HiveStorageEngine>(),
        gh<_i446.ReinstallGuard>(),
      ),
      preResolve: true,
    );
    gh.lazySingleton<_i812.HttpService>(
      () => _i812.HttpService(gh<_i361.Dio>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i249.APIHandler>(
      () => _i249.APIHandler(gh<_i1010.HttpService>()),
    );
    gh.lazySingleton<_i665.AuthRepository>(
      () => _i665.AuthRepository(gh<_i1010.APIHandler>()),
    );
    gh.lazySingleton<_i178.LoginUsecase>(
      () => _i178.LoginUsecase(gh<_i651.AuthRepository>()),
    );
    gh.factory<_i201.LoginProvider>(
      () => _i201.LoginProvider(gh<_i178.LoginUsecase>()),
    );
    return this;
  }
}

class _$SecurityModule extends _i858.SecurityModule {}

class _$NetworkModule extends _i823.NetworkModule {}

class _$StorageModule extends _i790.StorageModule {}
