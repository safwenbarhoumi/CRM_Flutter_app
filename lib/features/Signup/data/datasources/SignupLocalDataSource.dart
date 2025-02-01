import 'dart:convert';
import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/errors/expentions.dart';
import '../models/SignupModel.dart';

class SignupLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedSignup";

  SignupLocalDataSource({required this.cache});

  void cacheSignupData(SignupModel signupData) {
    cache.saveData(
      key: key,
      value: json.encode(signupData.toJson()),
    );
  }

  Future<SignupModel> getCachedSignupData() async {
    final jsonString = cache.getDataString(key: key);
    if (jsonString != null) {
      return SignupModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(errorMessage: "No cached signup data found");
    }
  }
}
