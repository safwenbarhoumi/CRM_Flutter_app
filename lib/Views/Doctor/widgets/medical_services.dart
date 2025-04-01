import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../model/medical_services_model.dart';
import '../screens/doctorByCategorie.dart';

class MedicalServices extends StatelessWidget {
  const MedicalServices({
    Key? key,
    required this.medicalServices,
  }) : super(key: key);

  final List<MedicalServicesModel> medicalServices;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: GridView.count(
      physics:
          const NeverScrollableScrollPhysics(), // Empêche un double scrolling
      shrinkWrap: true, // Permet au GridView de s'adapter à son contenu
      crossAxisCount: 4,
      mainAxisSpacing: 10.w,
      crossAxisSpacing: 10.w,
      childAspectRatio: 0.9, // Ajuste la hauteur des éléments
      children: List.generate(
        medicalServices.length,
        (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorByCategorieScreen(
                    category: medicalServices[index].title,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min, // Permet d'éviter le débordement
              children: [
                Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: medicalServices[index].color,
                  ),
                  child: Image.asset(
                    medicalServices[index].image,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 5.h),
                Flexible(
                  // Permet au texte de s'adapter
                  child: Text(
                    medicalServices[index].title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 14.sp,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}
