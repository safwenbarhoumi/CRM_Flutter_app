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
    return GridView.count(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      mainAxisSpacing: 10.h, // Adjusted for screen responsiveness
      children: List.generate(
        medicalServices.length,
        (index) {
          return Column(
            children: [
              Container(
                height: 60.h, // Scaled height
                width: 60.w, // Scaled width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r), // Scaled radius
                  color: medicalServices[index].color,
                ),
                child: Image.asset(
                  medicalServices[index].image,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 5.h), // Scaled spacing
              Text(
                medicalServices[index].title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 14.sp, // Scaled font size
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
