import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors.dart';
import '../constants/images.dart';

class CustomAppBar extends StatelessWidget {
  final IconData icon;
  late bool backButton;
  late bool profile;

  CustomAppBar({
    Key? key,
    required this.icon,
    required this.backButton,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              backButton ? Navigator.pop(context) : {};
            },
            icon: Icon(
              icon,
              color: AppColors.black,
              size: 25.sp,
            ),
          ),
          profile
              ? Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AppImages.profile),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  height: 40.h,
                  width: 40.w,
                  child: Icon(
                    Icons.bookmark,
                    color: AppColors.black,
                    size: 25.sp,
                  ),
                ),
        ],
      ),
    );
  }
}
