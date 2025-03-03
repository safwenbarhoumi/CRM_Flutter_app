import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors.dart';

class DetailInfo extends StatelessWidget {
  final String text;
  final String number;
  final String? subtitle;

  const DetailInfo({
    Key? key,
    required this.text,
    required this.number,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Apply ScreenUtil to scale the font size
        Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 14.sp, // Using sp for text size scaling
              ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: number,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.blue,
                      fontSize: 20.sp, // Using sp for text size scaling
                    ),
              ),
              TextSpan(
                text: subtitle,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.textGrey,
                      fontSize: 12.sp, // Using sp for text size scaling
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
