import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:new_setup/core/core.dart';
import 'package:new_setup/models/models.dart' show LoginRequestModel;
import 'package:new_setup/network/network.dart';

@lazySingleton
class AuthRepository {
  final APIHandler _apiHandler;

  AuthRepository(this._apiHandler);

  Future<Either<AppException, Unit>> login(LoginRequestModel request) {
    return ApiHelper.safeApiCall(
      () => _apiHandler.postApiCall(
        apiName: AppEndpoints.login,
        params: request.toJson(),
      ),
      (json) async {
        // final response = LoginResponseModel.fromJson(json);
        // await SharedPreferencesHelper.instance.setLoggedIn();
        // await _secureStorageHelper.saveAccessToken(
        //   response.credentials?.accessToken ?? '',
        // );
        // await _secureStorageHelper.saveRefreshToken(
        //   response.credentials?.refreshToken ?? '',
        // );
        // await SharedPreferencesHelper.instance.saveUserId(
        //   response.user?.id ?? "",
        // );

        return unit;
      },
    );
  }
}
