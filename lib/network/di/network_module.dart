import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:new_setup/core/constants/endpoints.dart';
import 'package:new_setup/core/storage/secure_storage.dart';
import 'package:new_setup/network/network.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(SecureStorageHelper storage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEndpoints.baseUrl,
        contentType: 'application/json; charset=utf-8',
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      AuthInterceptor(dio: dio, secureStorageHelper: storage),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true),
      );
    }
    return dio;
  }
}
