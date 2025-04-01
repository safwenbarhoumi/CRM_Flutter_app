import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../constants/colors.dart';
import '../constants/text.dart';
import '../data/doctor_information_data.dart';
import '../model/doctor_information_model.dart';
import '../widgets/doctors_information.dart';

class AllDoctorsScreen extends StatefulWidget {
  @override
  _AllDoctorsScreenState createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  List<DoctorInformationModel> doctorInformations = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.8.186:8091/doctor/all'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          doctorInformations = data
              .map((json) => DoctorInformationModel.fromJson(json))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Erreur ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Impossible de récupérer les données.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All doctors",
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
                SizedBox(height: 20.h),

                // Affichage des données, du loader ou du message d'erreur
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else if (errorMessage != null)
                  Center(
                      child: Text(errorMessage!,
                          style: TextStyle(color: Colors.red)))
                else if (doctorInformations.isEmpty)
                  Center(child: Text("Aucun docteur trouvé."))
                else
                  DoctorInformation(doctorInformations: doctorInformations),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
