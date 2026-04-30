// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/core.dart' as _i446;
import 'core/storage/secure_storage.dart' as _i682;
import 'network/api_handler.dart' as _i249;
import 'network/http_service.dart' as _i812;
import 'network/network.dart' as _i1010;
import 'providers/login_provider.dart' as _i201;
import 'repostories/auth_repository.dart' as _i127;
import 'repostories/repositories.dart' as _i707;
import 'usecases/login_usecase.dart' as _i178;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i682.SecureStorageHelper>(
      () => _i682.SecureStorageHelper(),
    );
    gh.lazySingleton<_i812.HttpService>(
      () => _i812.HttpService(gh<_i446.SecureStorageHelper>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i249.APIHandler>(
      () => _i249.APIHandler(gh<_i1010.HttpService>()),
    );
    gh.lazySingleton<_i127.AuthRepository>(
      () => _i127.AuthRepository(gh<_i1010.APIHandler>()),
    );
    gh.lazySingleton<_i178.LoginUsecase>(
      () => _i178.LoginUsecase(gh<_i707.AuthRepository>()),
    );
    gh.factory<_i201.LoginProvider>(
      () => _i201.LoginProvider(gh<_i178.LoginUsecase>()),
    );
    return this;
  }
}
