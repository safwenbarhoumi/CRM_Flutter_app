import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/profile_model.dart';
import '../core/databases/api/end_points.dart';

class ProfileService {
  Future<bool> completeProfile(ProfileModel profile, String role) async {
    String url = "${EndPoints.baserUrl}/${role.toLowerCase()}/complete-profile";

    print("📡 Sending profile data to: $url");
    print("📝 Data: ${profile.toJson()}");
    print("📡 Sending profile data: ${jsonEncode(profile.toJson())}");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(profile.toJson()),
      );

      print("🔄 Response status: ${response.statusCode}");
      print("📩 Response body: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("🚨 Error in API call: $e");
      return false;
    }
  }
}
