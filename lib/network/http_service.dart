import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:new_setup/core/core.dart';
import 'package:new_setup/network/network.dart';

@lazySingleton
class HttpService {
  late final Dio _dio;
  final SecureStorageHelper _secureStorageHelper;
  final CancelToken _cancelToken = CancelToken();

  HttpService(this._secureStorageHelper) {
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppEndpoints.baseUrl,
        contentType: 'application/json; charset=utf-8',
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(
      AuthInterceptor(dio: _dio, secureStorageHelper: _secureStorageHelper),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true),
      );
    }
  }

  void cancelRequests() => _cancelToken.cancel('Request canceled');

  Future<T> _request<T>(
    String path, {
    required String method,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final body = switch ((method, data)) {
        ('GET', _) => null,
        (_, FormData formData) => formData,
        (_, null) => null,
        (_, Object map) => jsonEncode(map),
      };

      final response = await _dio.request(
        path,
        data: body,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(method: method),
        cancelToken: _cancelToken,
      );

      if (_isSuccess(response)) {
        return response.data as T;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Request failed with status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ExceptionMapper.fromDioError(e);
    } catch (_) {
      throw UnknownException(message: 'An unexpected error occurred.');
    }
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _request(
    path,
    method: 'GET',
    queryParameters: queryParameters,
    options: options,
  );

  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _request(
    path,
    method: 'POST',
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<T> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _request(
    path,
    method: 'PUT',
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<T> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _request(
    path,
    method: 'PATCH',
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<T> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _request(
    path,
    method: 'DELETE',
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  bool _isSuccess(Response response) =>
      response.statusCode != null &&
      response.statusCode! >= 200 &&
      response.statusCode! < 300;

  @disposeMethod
  void dispose() => _cancelToken.cancel('HttpService disposed');
}
