import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/login.dart';
import '../core/databases/api/end_points.dart';
import '../core/databases/cache/cache_helper.dart';

class LoginService {
  Future<String?> login(LoginModel loginModel) async {
    final url = Uri.parse(
        "${EndPoints.baserUrl}/${loginModel.role.toLowerCase()}/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(loginModel.toJson()),
    );

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id']; // ✅ Return user ID
    } else {
      return null;
    }
  }
}
