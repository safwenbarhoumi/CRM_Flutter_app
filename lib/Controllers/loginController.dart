import 'package:flutter/material.dart';
import '../core/databases/cache/cache_helper.dart';
import '../services/loginService.dart';
import '../Models/login.dart';

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
      role: role.toUpperCase(), // Assurer que le rôle est en MAJUSCULES
    );

    bool success = await _loginService.login(loginModel);

    if (success) {
      await CacheHelper().saveData(key: "isAuthenticated", value: true);
      await CacheHelper().saveData(key: "email", value: email);
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }
}
