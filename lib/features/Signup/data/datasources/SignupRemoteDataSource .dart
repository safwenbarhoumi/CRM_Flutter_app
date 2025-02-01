import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../models/SignupModel.dart';

class SignupRemoteDataSource {
  final ApiConsumer api;

  SignupRemoteDataSource({required this.api});

  Future<SignupModel> signup(SignupModel signupData) async {
    final response = await api.post(
      EndPoints.signup,
      data: signupData.toJson(),
    );
    return SignupModel.fromJson(response);
  }
}
