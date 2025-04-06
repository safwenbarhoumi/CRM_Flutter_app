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

import 'allDoctorList.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({Key? key}) : super(key: key);

  @override
  _HomeDoctorScreenState createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  List<DoctorInformationModel> doctorInformations = [];
  bool isLoading = true;

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
        print("doctor data fel mockla ---------------------> $data");
        isLoading = false;
      });
    } catch (e) {
      print(
          "\u274C Erreur lors de la r\u00e9cup\u00e9ration des donn\u00e9es : $e");
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
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 24.sp,
                      ),
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
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontSize: 18.sp,
                          ),
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : doctorInformations.isEmpty
                        ? Center(
                            child: Text(
                              "Aucun docteur trouv\u00e9.",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          )
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
