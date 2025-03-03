import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/text.dart';
import 'detail_info.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w), // Using w for width
      height: 100.h, // Using h for height
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Wrap with Expanded to prevent overflow
          Expanded(
            child: DetailInfo(
              text: AppText.experience,
              number: '3',
              subtitle: ' yr',
            ),
          ),
          VerticalDivider(
            indent: 20.h, // Using h for height values like indent
            endIndent: 20.h,
            thickness: 1,
            color: AppColors.textGrey,
          ),
          Expanded(
            child: const DetailInfo(
              text: AppText.patient,
              number: '1121',
              subtitle: ' ps',
            ),
          ),
          VerticalDivider(
            indent: 20.h,
            endIndent: 20.h,
            thickness: 1,
            color: AppColors.textGrey,
          ),
          Expanded(
            child: const DetailInfo(
              text: AppText.rating,
              number: '5.0',
            ),
          ),
        ],
      ),
    );
  }
}
