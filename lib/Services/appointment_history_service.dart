import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppointmentHistoryService extends ChangeNotifier {
  List<String> _history = [];

  List<String> get history => _history;

  Future<void> fetchAppointmentHistory(
      String doctorId, String patientId) async {
    final url = Uri.parse(
        "http://localhost:8091/appointment-history/get-by-doctor-patient");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "doctorId": doctorId,
          "patientId": patientId,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _history = data.map((item) => item.toString()).toList();
      } else {
        _history = ["Error: ${response.statusCode}"];
      }
    } catch (e) {
      _history = ["Exception: $e"];
    }

    notifyListeners();
  }
}
