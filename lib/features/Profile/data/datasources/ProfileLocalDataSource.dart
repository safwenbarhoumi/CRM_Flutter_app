import 'dart:convert';
import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/errors/expentions.dart';
import '../models/ProfileModel.dart';

class ProfileLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedProfile";

  ProfileLocalDataSource({required this.cache});

  void cacheProfileData(ProfileModel profileData) {
    cache.saveData(
      key: key,
      value: json.encode(profileData.toJson()),
    );
  }

  Future<ProfileModel> getCachedProfileData() async {
    final jsonString = cache.getDataString(key: key);
    if (jsonString != null) {
      return ProfileModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(errorMessage: "No cached profile data found");
    }
  }
}
