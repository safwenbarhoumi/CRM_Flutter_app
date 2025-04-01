import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors.dart';
import '../constants/text.dart';
import '../data/doctor_information_data.dart';
import '../data/medical_services_data.dart';
import '../model/doctor_information_model.dart';
import '../model/medical_services_model.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/doctors_information.dart';
import '../widgets/medical_services.dart';
import '../widgets/textbox.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'allDoctorList.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({Key? key}) : super(key: key);

  @override
  _HomeDoctorScreenState createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  List<DoctorInformationModel> doctorInformations = [];
  bool isLoading = true; // Indicateur de chargement

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      List<DoctorInformationModel> data = await fetchTop10Doctors();
      setState(() {
        doctorInformations = data;
        isLoading = false;
      });
    } catch (e) {
      print("❌ Erreur lors de la récupération des données : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<MedicalServicesModel> medicalServices = medicalService;

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
                CustomAppBar(
                  backButton: false,
                  profile: true,
                  icon: Icons.sort,
                ),
                SizedBox(height: 20.h),
                Text(
                  AppText.findDoctor,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 20.h),
                const CustomTextBox(),
                SizedBox(height: 20.h),
                MedicalServices(medicalServices: medicalServices),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppText.topDoctors,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllDoctorsScreen()),
                        );
                      },
                      child: Text(
                        AppText.viewAll,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),

                // 🔄 AFFICHAGE DES DONNÉES OU LOADER
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : doctorInformations.isEmpty
                        ? Center(child: Text("Aucun docteur trouvé."))
                        : DoctorInformation(
                            doctorInformations: doctorInformations),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
