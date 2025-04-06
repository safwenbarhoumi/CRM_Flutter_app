import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BookingService {
  static const String baseUrl = 'http://192.168.1.104:8091/appointments';

  static Future<Map<String, List<String>>> getAvailableTimes(
      String doctorId) async {
    final url = Uri.parse('$baseUrl/available-times/$doctorId');
    final response = await http.get(url);
    debugPrint("------->getAvailableTimes status: ${response.statusCode}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("Available times data: $data");

      return Map<String, List<String>>.from(
        data.map((key, value) => MapEntry(key, List<String>.from(value))),
      );
    } else {
      throw Exception('Failed to load available times');
    }
  }

  static Future<Map<String, dynamic>> makeAppointment(
    String doctorId,
    String patientId,
    String date,
    String time,
  ) async {
    final url = Uri.parse('$baseUrl/make');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'doctorId': doctorId,
        'patientId': patientId,
        'date': date,
        'time': time,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to make appointment');
    }
  }
}
