// ignore_for_file: unused_element

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_setup/core/core.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final SecureStorageHelper secureStorageHelper;

  bool _isRefreshing = false;
  Future<bool>? _refreshFuture;

  AuthInterceptor({required this.dio, required this.secureStorageHelper});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await secureStorageHelper.getAccessToken();

      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (e) {
      debugPrint('Unexpected error reading token: $e');
    }

    handler.next(options);
  }

  Future<void> _handleCorruptedStorage() async {
    try {
      await secureStorageHelper.clear();
      debugPrint('Cleared corrupted secure storage');
    } catch (e) {
      debugPrint('Failed to clear secure storage: $e');
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final bool shouldRefresh = statusCode == 401;

    if (!shouldRefresh) {
      return handler.reject(err);
    }

    try {
      if (!_isRefreshing) {
        _isRefreshing = true;
        _refreshFuture = _refreshToken();
      }

      final refreshed = await _refreshFuture;
      _isRefreshing = false;

      if (refreshed != true) return _redirectToLogin(handler, err);

      final newToken = await secureStorageHelper.getAccessToken();
      if (newToken == null) return _redirectToLogin(handler, err);

      final requestOptions = err.requestOptions.copyWith();
      requestOptions.headers['Authorization'] = 'Bearer $newToken';

      final response = await dio.fetch(requestOptions);
      return handler.resolve(response);
    } catch (e) {
      debugPrint('AuthInterceptor error: $e');
      return handler.reject(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await secureStorageHelper.getRefreshToken();
    final accessToken = await secureStorageHelper.getAccessToken();

    if (refreshToken == null || accessToken == null) return false;

    try {
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: AppEndpoints.baseUrl,
          contentType: 'application/json',
        ),
      );

      final response = await refreshDio.post(
        AppEndpoints.refreshToken,
        data: {'accessToken': accessToken, 'refreshToken': refreshToken},
      );

      if (_isSuccess(response)) {
        // final authResponse = CustomerLoginResponseModel.fromJson(response.data);

        // final credentials = authResponse.credentials;

        // if (credentials?.accessToken == null ||
        //     credentials?.refreshToken == null) {
        //   return false;
        // }

        // await secureStorageHelper.saveAccessToken(credentials!.accessToken!);
        // await secureStorageHelper.saveRefreshToken(credentials.refreshToken!);
        // await SharedPreferencesHelper.instance.saveUserId(
        //   authResponse.user?.id ?? "",
        // );
        return true;
      }
    } catch (e) {
      debugPrint('Refresh failed: $e');
    }

    return false;
  }

  bool _isSuccess(Response response) =>
      response.statusCode != null &&
      response.statusCode! >= 200 &&
      response.statusCode! < 300;

  Future<void> _redirectToLogin(
    ErrorInterceptorHandler handler,
    DioException err,
  ) async {
    await secureStorageHelper.clear();
    // final context = navigatorKey.currentContext;
    // if (context == null || !context.mounted) return handler.reject(err);

    // final userRole = context.read<RoleProvider>().selectedRole;
    // final loginScreen = userRole == UserRole.vendor
    //     ? LoginScreenBusiness()
    //     : LoginScreen();

    // PersistentNavBarNavigator.pushNewScreen(
    //   context,
    //   pageTransitionAnimation: PageTransitionAnimation.fade,
    //   screen: loginScreen,
    // );

    handler.reject(err);
  }
}
