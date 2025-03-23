import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/login.dart';

class LoginService {
  Future<bool> login(LoginModel loginModel) async {
    final url = Uri.parse(
        "http://192.168.1.104:8091/${loginModel.role.toLowerCase()}/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(loginModel.toJson()),
    );

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
