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
    return SizedBox(
      height: 100.h,
      width: 90.w,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Éviter l'overflow vertical
        mainAxisAlignment: MainAxisAlignment.center, // Centrer les éléments
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 16.sp, // Adapter la taille du texte
                ),
          ),
          SizedBox(height: 5.h), // Espacement adaptatif
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 18.sp, // Adapter la taille
                        color: AppColors.blue,
                      ),
                ),
                if (subtitle != null)
                  TextSpan(
                    text: " $subtitle",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 14.sp, // Adapter la taille
                          color: AppColors.textGrey,
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
