import 'dart:convert';
import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/errors/expentions.dart';
import '../models/LoginModel.dart';

class LoginLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedLogin";

  LoginLocalDataSource({required this.cache});

  void cacheLoginData(LoginModel loginData) {
    cache.saveData(
      key: key,
      value: json.encode(loginData.toJson()),
    );
  }

  Future<LoginModel> getCachedLoginData() async {
    final jsonString = cache.getDataString(key: key);
    if (jsonString != null) {
      return LoginModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(errorMessage: "No cached login data found");
    }
  }
}
