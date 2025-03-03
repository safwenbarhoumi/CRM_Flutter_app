import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../data/data.dart';
import '../model/model.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MedicalServicesModel> medicalServices = medicalService;
    final List<DoctorInformationModel> doctorInformations = doctorInformation;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    Text(
                      AppText.viewAll,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
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
