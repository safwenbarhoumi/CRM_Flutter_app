import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/signup.dart';
import '../core/databases/api/end_points.dart';

class SignUpService {
  Future<String> signUp(SignUpModel user) async {
    final String url =
        "${EndPoints.baserUrl}/${user.role.toLowerCase()}/signup";
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception("Failed to sign up");
    }
  }
}
