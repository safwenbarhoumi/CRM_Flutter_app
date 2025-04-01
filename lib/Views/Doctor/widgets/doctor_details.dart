import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/text.dart';
import '../model/doctor_information_model.dart';
import 'detail_info.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({Key? key, required this.doctorInformationModel})
      : super(key: key);

  final DoctorInformationModel doctorInformationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 100.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: DetailInfo(
              text: AppText.experience,
              number:
                  '${doctorInformationModel.nExperience}', // Static value for experience (can be dynamic based on model if needed)
              subtitle: ' yr',
            ),
          ),
          VerticalDivider(
            indent: 20.h,
            endIndent: 20.h,
            thickness:
                1, // Use pixel thickness or the appropriate unit, not `w`
            color: AppColors.textGrey,
          ),
          Expanded(
            child: DetailInfo(
              text: AppText.patient,
              number:
                  '${doctorInformationModel.nPatient}', // Static value for patients (can be dynamic based on model if needed)
              subtitle: ' ps',
            ),
          ),
          VerticalDivider(
            indent: 20.h,
            endIndent: 20.h,
            thickness: 1, // Same adjustment here for thickness
            color: AppColors.textGrey,
          ),
          Expanded(
            child: DetailInfo(
              text: AppText.rating,
              number: '${doctorInformationModel.star}', // Use the dynamic value
              // subtitle: '${doctorInformationModel.specialist}', // If no subtitle is required
            ),
          ),
        ],
      ),
    );
  }
}
