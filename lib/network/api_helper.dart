import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_setup/network/network.dart';

typedef JsonParser<T> = FutureOr<T> Function(Map<String, dynamic> json);

class ApiHelper {
  static Future<Either<AppException, T>> safeApiCall<T>(
    Future<Map<String, dynamic>?> Function() apiCall,
    JsonParser<T> parser,
  ) async {
    try {
      final data = await apiCall();
      if (data != null) {
        return Right(await parser(data));
      } else {
        return Left(ServerException(message: 'An error occurred'));
      }
    } on AppException catch (e) {
      log(e.toString());
      return Left(e);
    } catch (error) {
      log(error.toString());
      return Left(UnknownException(message: error.toString()));
    }
  }
}
