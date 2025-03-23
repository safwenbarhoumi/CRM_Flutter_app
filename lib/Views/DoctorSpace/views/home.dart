import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/data.dart';
import '../model/speciality.dart';
import 'doctor_info.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Add this import

String selectedCategorie = "Adults";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ["Adults", "Childrens", "Womens", "Mens"];
  late List<SpecialityModel2> specialities;

  @override
  void initState() {
    super.initState();
    specialities = getSpeciality().cast<SpecialityModel2>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      drawer: Drawer(child: Container()),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: 10.h, // Using ScreenUtil for height
            horizontal: 24.w, // Using ScreenUtil for width
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.h), // Using ScreenUtil for height
              Text(
                "Find Your \nConsultation",
                style: TextStyle(
                  color: Colors.black87.withOpacity(0.8),
                  fontSize: 30.sp, // Using ScreenUtil for font size
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40.h), // Using ScreenUtil for height
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 24.w), // Using ScreenUtil for width
                height: 50.h, // Using ScreenUtil for height
                decoration: BoxDecoration(
                  color: Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(
                      14.r), // Using ScreenUtil for radius
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    SizedBox(width: 10.w), // Using ScreenUtil for width
                    Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 19.sp, // Using ScreenUtil for font size
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h), // Using ScreenUtil for height
              Text(
                "Categories",
                style: TextStyle(
                  color: Colors.black87.withOpacity(0.8),
                  fontSize: 25.sp, // Using ScreenUtil for font size
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h), // Using ScreenUtil for height
              Container(
                height: 30.h, // Using ScreenUtil for height
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategorieTile(
                      categorie: categories[index],
                      isSelected: selectedCategorie == categories[index],
                      context: this,
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h), // Using ScreenUtil for height
              Container(
                height: 250.h, // Using ScreenUtil for height
                child: ListView.builder(
                  itemCount: specialities.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SpecialistTile(
                      imgAssetPath: specialities[index].imgAssetPath,
                      speciality: specialities[index].speciality,
                      noOfDoctors: specialities[index].noOfDoctors,
                      backColor: specialities[index].backgroundColor,
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h), // Using ScreenUtil for height
              Text(
                "Doctors",
                style: TextStyle(
                  color: Colors.black87.withOpacity(0.8),
                  fontSize: 25.sp, // Using ScreenUtil for font size
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h), // Using ScreenUtil for height
              DoctorsTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorieTile extends StatefulWidget {
  final String categorie;
  final bool isSelected;
  _HomePageState context;
  CategorieTile(
      {required this.categorie,
      required this.isSelected,
      required this.context});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.context.setState(() {
          selectedCategorie = widget.categorie;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        margin: EdgeInsets.only(left: 8.w),
        height: 30.h,
        decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xffFFD0AA) : Colors.white,
            borderRadius: BorderRadius.circular(30.r)),
        child: Text(
          widget.categorie,
          style: TextStyle(
              color: widget.isSelected ? Color(0xffFC9535) : Color(0xffA1A1A1)),
        ),
      ),
    );
  }
}

class SpecialistTile extends StatelessWidget {
  final String imgAssetPath;
  final String speciality;
  final int noOfDoctors;
  final Color backColor;
  SpecialistTile(
      {required this.imgAssetPath,
      required this.speciality,
      required this.noOfDoctors,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
          color: backColor, borderRadius: BorderRadius.circular(24.r)),
      padding: EdgeInsets.only(top: 16.h, right: 16.w, left: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            speciality,
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            "$noOfDoctors Doctors",
            style: TextStyle(color: Colors.white, fontSize: 13.sp),
          ),
          Image.asset(
            imgAssetPath,
            height: 160.h,
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}

class DoctorsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DoctorsInfo()));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffFFEEE0),
            borderRadius: BorderRadius.circular(20.r)),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
        child: Row(
          children: <Widget>[
            Image.asset(
              "assets/doctor_pic.png",
              height: 50.h,
            ),
            SizedBox(
              width: 17.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Dr. Stefeni Albert",
                  style: TextStyle(color: Color(0xffFC9535), fontSize: 19.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Heart Specialist",
                  style: TextStyle(fontSize: 15.sp),
                )
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 9.h),
              decoration: BoxDecoration(
                  color: Color(0xffFBB97C),
                  borderRadius: BorderRadius.circular(13.r)),
              child: Text(
                "Call",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
