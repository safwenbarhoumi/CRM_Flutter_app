import 'package:happytech_clean_architecture/core/errors/error_model.dart';

import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/errors/expentions.dart';
import '../models/SignupModel.dart';

class SignupRemoteDataSource {
  final ApiConsumer api;

  SignupRemoteDataSource({required this.api});

  Future<SignupModel> signup(SignupModel signupData) async {
    try {
      print("📤 Request Payload: ${signupData.toJson()}");
      final response = await api.post(
        EndPoints.signup,
        data: signupData.toJson(),
      );
      print("📥 Response: $response");

      if (response == null) {
        throw ServerException("Réponse API null !" as ErrorModel);
      }

      // Ensure the response is a valid JSON object
      if (response is! Map<String, dynamic>) {
        throw ServerException("Réponse API invalide !" as ErrorModel);
      }

      return SignupModel.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException("Erreur serveur : }" as ErrorModel);
    } catch (e) {
      throw Exception("Erreur lors de l'inscription : ${e.toString()}");
    }
  }
}
