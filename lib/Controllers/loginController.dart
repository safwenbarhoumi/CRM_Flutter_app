import 'package:flutter/material.dart';
import '../core/databases/cache/cache_helper.dart';
import '../services/loginService.dart';
import '../Models/login.dart';

class LoginController with ChangeNotifier {
  final LoginService _loginService = LoginService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password, String role) async {
    _isLoading = true;
    notifyListeners();

    final loginModel = LoginModel(
      email: email.trim(),
      password: password,
      role: role.toUpperCase(),
      id: '',
    );

    final String? userId = (await _loginService.login(loginModel)) as String?;

    print("userId:===================> $userId");

    if (userId != null) {
      await CacheHelper().saveData(key: "isAuthenticated", value: true);
      await CacheHelper().saveData(key: "email", value: email);
      await CacheHelper().saveData(key: "role", value: role.toUpperCase());
      await CacheHelper().saveData(key: "id", value: userId);
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
