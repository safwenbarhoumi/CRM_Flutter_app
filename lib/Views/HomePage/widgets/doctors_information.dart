import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/text.dart';
import '../model/doctor_information_model.dart';
import '../screens/doctor_screen.dart';

class DoctorInformation extends StatelessWidget {
  final List<DoctorInformationModel> doctorInformations;
  const DoctorInformation({
    Key? key,
    required this.doctorInformations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: doctorInformations.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => DoctorScreen(
                doctorInformationModel: doctorInformations[index],
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          );
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(bottom: 15.h), // Scaled margin
          child: SizedBox(
            height: 80.h, // Scaled height
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80.h, // Scaled height
                  width: 80.w, // Scaled width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r), // Scaled radius
                    image: DecorationImage(
                      image: AssetImage(doctorInformations[index].image),
                    ),
                  ),
                ),
                SizedBox(width: 15.w), // Scaled spacing
                Expanded(
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctorInformations[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                          fontSize: 16.sp), // Scaled font size
                                ),
                                Row(
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                                fontSize: 14.sp), // Scaled font
                                        children: [
                                          TextSpan(
                                              text: doctorInformations[index]
                                                  .specialist),
                                          const TextSpan(text: '  •  '),
                                          TextSpan(
                                              text: doctorInformations[index]
                                                  .hospital),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                5,
                                (index) => Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.yellow,
                                      size: 20.sp, // Scaled icon size
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 25.h, // Scaled height
                          width: 56.w, // Scaled width
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(5.r), // Scaled radius
                            color: AppColors.boxGreen,
                          ),
                          child: Center(
                            child: Text(
                              AppText.open,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: AppColors.green,
                                    fontSize: 14.sp, // Scaled font size
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
