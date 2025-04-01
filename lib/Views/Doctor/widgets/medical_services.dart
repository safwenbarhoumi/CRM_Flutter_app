import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../model/medical_services_model.dart';

class MedicalServices extends StatelessWidget {
  const MedicalServices({
    Key? key,
    required this.medicalServices,
  }) : super(key: key);

  final List<MedicalServicesModel> medicalServices;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap the GridView with SingleChildScrollView
      child: GridView.count(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        mainAxisSpacing: 10.w, // Use flutter_screenutil for spacing
        crossAxisSpacing: 10.w, // Use flutter_screenutil for spacing
        children: List.generate(
          medicalServices.length,
          (index) {
            return Flex(
              direction: Axis.vertical, // Flex with vertical direction
              mainAxisSize:
                  MainAxisSize.min, // Ensure the Flex doesn't overflow
              children: [
                Container(
                  height: 60.h, // Use flutter_screenutil for height
                  width: 60.w, // Use flutter_screenutil for width
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0.r), // Radius adaptively
                    color: medicalServices[index].color,
                  ),
                  child: Image.asset(
                    medicalServices[index].image,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 5.h), // Adaptive spacing
                Text(
                  medicalServices[index].title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 14.sp, // Adaptive text size
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
