import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:new_setup/network/network.dart';

@lazySingleton
class APIHandler {
  final HttpService _httpService;
  final Connectivity _connectivity;

  APIHandler(this._httpService) : _connectivity = Connectivity();

  Future<void> ensureConnected() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      final hasConnection = connectivityResult.any(
        (r) => r != ConnectivityResult.none,
      );
      if (!hasConnection) {
        throw NetworkException(
          message:
              "No internet connection. Please check your connection and try again.",
        );
      }
    } on PlatformException {
      throw NetworkException(message: "Failed to check connectivity");
    }
  }

  Future<T> getApiCall<T>({
    required String apiName,
    Map<String, dynamic>? queryParameters,
  }) async {
    await ensureConnected();
    final response = await _httpService.get(
      apiName,
      queryParameters: queryParameters,
    );
    return response as T;
  }

  Future<T> postApiCall<T>({
    required String apiName,
    Object? params,
    Map<String, dynamic>? queryParameters,
  }) async {
    await ensureConnected();
    final response = await _httpService.post(
      apiName,
      data: params,
      queryParameters: queryParameters,
    );
    return response as T;
  }

  Future<T> postMediaApiCall<T>({
    required String apiName,
    Object? params,
  }) async {
    await ensureConnected();
    final response = await _httpService.post(apiName, data: params);
    return response as T;
  }

  Future<T> patchApiCall<T>({required String apiName, Object? params}) async {
    await ensureConnected();
    final response = await _httpService.patch(apiName, data: params);
    return response as T;
  }

  Future<T> deleteApiCall<T>({required String apiName, Object? params}) async {
    await ensureConnected();
    final response = await _httpService.delete(apiName, data: params);
    return response as T;
  }

  Future<T> putApiCall<T>({required String apiName, Object? params}) async {
    await ensureConnected();
    final response = await _httpService.put(apiName, data: params);
    return response as T;
  }
}
