import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Background Image Widget
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/image-medical.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// Greeting Text Widget
class GreetingText extends StatelessWidget {
  const GreetingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 80.h, left: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HELLO',
            style: GoogleFonts.b612(
              color: Colors.black,
              fontSize: 50.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Welcome to Medico!',
            style: GoogleFonts.b612(
              color: Colors.indigo[800],
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Authentication Buttons Widget
class AuthButtons extends StatelessWidget {
  final VoidCallback onSignInPressed;
  final VoidCallback onRegisterPressed;

  const AuthButtons({
    Key? key,
    required this.onSignInPressed,
    required this.onRegisterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 220.h,
          decoration: BoxDecoration(
            color: Colors.black26.withOpacity(0.25),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildButton(
                text: "Sign in",
                textColor: Colors.white,
                backgroundColor: Colors.indigo[800]!,
                onPressed: onSignInPressed,
              ),
              _buildButton(
                text: "Create an Account",
                textColor: Colors.black,
                backgroundColor: Colors.white,
                onPressed: onRegisterPressed,
              ),
            ],
          ),
        ),
        SizedBox(height: 80.h),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required Color textColor,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 0.9.sw,
      padding: EdgeInsets.all(16.w),
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          child: Text(
            text,
            style: GoogleFonts.lato(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: backgroundColor,
            backgroundColor: backgroundColor,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.r),
            ),
          ),
        ),
      ),
    );
  }
}
