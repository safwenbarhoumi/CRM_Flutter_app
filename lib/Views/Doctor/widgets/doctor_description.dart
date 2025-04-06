import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/databases/api/end_points.dart';
import '../../../core/databases/cache/cache_helper.dart';
import '../../BookingScreen/booking_screen.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../constants/text.dart';
import '../model/doctor_information_model.dart';
import 'doctor_details.dart';

class DoctorDescription extends StatelessWidget {
  const DoctorDescription({
    Key? key,
    required this.doctorInformationModel,
  }) : super(key: key);

  final DoctorInformationModel doctorInformationModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctorInformationModel.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.headlineSmall,
                  children: [
                    TextSpan(text: doctorInformationModel.specialist),
                    const TextSpan(text: '  •  '),
                    TextSpan(text: doctorInformationModel.location),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
              '${doctorInformationModel.description} ,,, ${doctorInformationModel.star}'),
          SizedBox(height: 2.h),
          DoctorDetails(doctorInformationModel: doctorInformationModel),
          SizedBox(height: 2.h),
          Row(
            children: [
              Container(
                height: 7.h,
                width: 7.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.blue,
                ),
                child: Image.asset(
                  AppImages.comments,
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.green,
                  ),
                  child: Center(
                    child: GestureDetector(
                      /*onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingScreen(
                              patientId: '67d5b2014ea30a4efe6ce02f',
                              doctorId: '67f0f5821b61281b787d1952',
                            ),
                          ),
                        );
                      },*/

                      onTap: () async {
                        String? patientId =
                            CacheHelper().getDataString(key: 'id');
                        print("Patient ID: $patientId");

                        if (patientId == null || patientId.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Patient non connecté')),
                          );
                          return;
                        }

                        final doctorEmail = doctorInformationModel
                            .title; // ← ici tu dois t’assurer que "title" contient bien l’email !
                        print("Doctor email used to fetch ID: $doctorEmail");

                        final doctorId =
                            "await fetchDoctorIdByEmail(doctorEmail!)";

                        if (doctorId == null || doctorId.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "Impossible de récupérer l'identifiant du docteur")),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingScreen(
                              patientId: patientId,
                              doctorId: doctorId,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        AppText.makeAppointment,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
