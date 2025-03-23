import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/signup.dart';

class SignUpService {
  Future<String> signUp(SignUpModel user) async {
    final String url =
        "http://192.168.1.104:8091/${user.role.toLowerCase()}/signup";
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
