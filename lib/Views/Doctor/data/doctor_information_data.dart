import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/doctor_information_model.dart';

Future<List<DoctorInformationModel>> fetchAllDoctors() async {
  final response =
      await http.get(Uri.parse('http://192.168.8.186:8091/doctor/all'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    // Maps the JSON list to a list of DoctorInformationModel instances.
    return data.map((json) => DoctorInformationModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load doctors');
  }
}

Future<List<DoctorInformationModel>> fetchDoctorsByCategory(
    String category) async {
  final response = await http
      .get(Uri.parse('http://192.168.8.186:8091/doctor/category/$category'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => DoctorInformationModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load doctors for category $category');
  }
}

Future<List<DoctorInformationModel>> fetchTop10Doctors() async {
  final response =
      await http.get(Uri.parse('http://192.168.8.186:8091/doctor/top10'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    // Maps the JSON list to a list of DoctorInformationModel instances.
    return data.map((json) => DoctorInformationModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load top doctors');
  }
}
