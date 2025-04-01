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
          margin: EdgeInsets.only(bottom: 15.h),
          child: SizedBox(
            height: 80.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: doctorInformations[index].image != null &&
                              doctorInformations[index].image!.isNotEmpty
                          ? AssetImage(doctorInformations[index].image!)
                              as ImageProvider
                          : const AssetImage(
                              'assets/images/default_doctor.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              doctorInformations[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontSize: 16.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      children: [
                                        TextSpan(
                                            text: doctorInformations[index]
                                                .specialist),
                                        const TextSpan(text: '  •  '),
                                        TextSpan(
                                            text: doctorInformations[index]
                                                .location),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  Icons.star_rounded,
                                  color: AppColors.yellow,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 25.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: AppColors.boxGreen,
                          ),
                          child: Center(
                            child: Text(
                              AppText.open,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: AppColors.green,
                                    fontSize: 14.sp,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
