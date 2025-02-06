import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../models/LoginModel.dart';

class LoginRemoteDataSource {
  final ApiConsumer api;

  LoginRemoteDataSource({required this.api});

  Future<LoginModel> login(LoginModel loginData) async {
    print("Requesting: ${EndPoints.login}");
    final response = await api.post(
      EndPoints.login,
      data: loginData.toJson(),
    );
    return LoginModel.fromJson(response);
  }
}
