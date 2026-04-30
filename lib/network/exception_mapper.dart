import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_setup/core/core.dart';
import 'package:new_setup/network/network.dart';

class ExceptionMapper {
  static AppException fromDioError(DioException dioError) {
    final statusCode = dioError.response?.statusCode;
    final errorMessage = dioError.response?.data;

    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(
          message: "Check your internet connection and try again.",
          code: statusCode,
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(statusCode, errorMessage);

      case DioExceptionType.cancel:
        return CancelException(message: "The operation was cancelled.");

      case DioExceptionType.badCertificate:
        return ServerException(
          message: "Bad SSL certificate.",
          code: statusCode,
        );

      case DioExceptionType.unknown:
        return NetworkException(
          message: "Check your internet connection and try again.",
          code: statusCode,
        );
    }
  }

  static AppException _handleBadResponse(int? statusCode, dynamic errorData) {
    debugPrint(errorData.toString());
    final formatted = formatErrorMessage(errorData);
    debugPrint("statusCode: $statusCode, message: $formatted");

    switch (statusCode) {
      case 401:
        return UnauthenticatedException(message: formatted, code: statusCode);
      case 400:
        return ServerException(message: formatted, code: statusCode);
      case 404:
        return NotFoundException(message: formatted, code: statusCode);
      case 502:
      case 503:
      case 504:
        return ServerException(
          message: "Something went wrong. Please try again later.",
          code: statusCode,
        );
      default:
        return ServerException(message: formatted, code: statusCode);
    }
  }
}
