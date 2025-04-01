import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/doctor_information_model.dart';

/// Fetches a list of all doctors from the server.
/// Returns a list of [DoctorInformationModel] instances.
/// Throws an [Exception] if the server call fails.
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

/// Fetches a list of the top 10 doctors from the server.
/// Returns a list of [DoctorInformationModel] instances.
/// Throws an [Exception] if the server call fails.
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

/*
List<DoctorInformationModel> doctorInformation = [
  DoctorInformationModel(
    id: '1',
    image: AppImages.doctor1,
    title: AppText.doctor1,
    specialist: AppText.heart,
    // hospital: AppText.hospital1,
    star: '50',
  ),
  DoctorInformationModel(
    id: '2',
    image: AppImages.doctor2,
    title: AppText.doctor2,
    specialist: AppText.eye,
    // hospital: AppText.hospital2,
    star: '60',
  ),
  DoctorInformationModel(
    id: '3',
    image: AppImages.doctor3,
    title: AppText.doctor3,
    specialist: AppText.ears,
    // hospital: AppText.hospital3,
    star: '80',
  ),
  DoctorInformationModel(
    id: '4',
    image: AppImages.doctor4,
    title: AppText.doctor4,
    specialist: AppText.skin,
    // hospital: AppText.hospital4,
    star: '20',
  ),
];

*/
