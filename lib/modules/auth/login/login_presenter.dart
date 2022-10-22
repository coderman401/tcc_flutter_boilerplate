// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:tcc_flutter_boilerplate/core/services/api_service.dart';
import 'package:tcc_flutter_boilerplate/core/services/shared_preferences_service.dart';

abstract class LoginViewContract {
  void loginSuccess(dynamic user);
  void loginError(dynamic error);
}

class LoginPresenter {
  late final LoginViewContract _view;
  late final ApiService _apiService;
  late final SharedPreferencesService _preferencesService;

  LoginPresenter(this._view) {
    _apiService = ApiService();
    _preferencesService = SharedPreferencesService();
  }

  void postLogin(dynamic payload) {
    _apiService.postRequest('login', payload: payload).then((value) {
      if (value!.status) {
        _view.loginSuccess(value.data);
      } else {
        _view.loginError(value.errors);
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void setSharedPreferences(dynamic data) async {
    await _preferencesService.setData('_token', data['token']);
    await _preferencesService.setData('userData', jsonEncode(data['user']));
  }
}
