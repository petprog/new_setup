import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:new_setup/models/auth/login_request_model.dart';
import 'package:new_setup/usecases/login_usecase.dart';

@injectable
class LoginProvider extends ChangeNotifier {
  final LoginUsecase _loginUsecase;

  LoginProvider(this._loginUsecase);

  bool isLoading = false;
  String? errorMessage;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> login(
    LoginRequestModel request, {
    VoidCallback? onSuccess,
    void Function(String)? onError,
  }) async {
    _setLoading(true);
    errorMessage = null;

    final result = await _loginUsecase(request);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        _setLoading(false);
        onError?.call(failure.message);
      },
      (_) {
        _setLoading(false);
        onSuccess?.call();
      },
    );
  }
}
