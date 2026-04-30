import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:new_setup/models/models.dart';
import 'package:new_setup/network/network.dart';
import 'package:new_setup/repositories/repositories.dart';

@lazySingleton
class LoginUsecase {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  Future<Either<AppException, Unit>> call(LoginRequestModel request) =>
      _repository.login(request);
}
