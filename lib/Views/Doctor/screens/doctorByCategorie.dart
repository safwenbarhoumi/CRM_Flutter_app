import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../constants/colors.dart';
import '../constants/text.dart';
import '../data/doctor_information_data.dart';
import '../model/doctor_information_model.dart';
import '../widgets/doctors_information.dart';

class DoctorByCategorieScreen extends StatefulWidget {
  final String category;

  DoctorByCategorieScreen({required this.category});

  @override
  _DoctorByCategorieScreenState createState() =>
      _DoctorByCategorieScreenState();
}

class _DoctorByCategorieScreenState extends State<DoctorByCategorieScreen> {
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
      List<DoctorInformationModel> doctors =
          await fetchDoctorsByCategory(widget.category);
      setState(() {
        doctorInformations = doctors;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage =
            'Impossible de récupérer les docteurs pour cette catégorie.';
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
                    Text(
                      "   ${widget.category}",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
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
