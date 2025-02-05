import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../models/ProfileModel.dart';

class ProfileRemoteDataSource {
  final ApiConsumer api;

  ProfileRemoteDataSource({required this.api});

  Future<ProfileModel> getProfile() async {
    final response = await api.get(EndPoints.profile);
    return ProfileModel.fromJson(response);
  }

  Future<ProfileModel> updateProfile(ProfileModel profileData) async {
    final response = await api.patch(
      EndPoints.profile,
      data: profileData.toJson(),
    );
    return ProfileModel.fromJson(response);
  }
}
