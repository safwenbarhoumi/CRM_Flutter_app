import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialityModel {
  String imgAssetPath;
  String speciality;
  int noOfDoctors;
  Color backgroundColor;

  SpecialityModel({
    required this.imgAssetPath,
    required this.speciality,
    required this.noOfDoctors,
    required this.backgroundColor,
  });
}

List<SpecialityModel> getSpeciality() {
  List<SpecialityModel> specialities = [];

  // 1
  specialities.add(SpecialityModel(
    noOfDoctors: 10,
    speciality: "Cough & Cold",
    imgAssetPath: "assets/img1.png",
    backgroundColor: Color(0xffFBB97C),
  ));

  // 2
  specialities.add(SpecialityModel(
    noOfDoctors: 17,
    speciality: "Heart Specialist",
    imgAssetPath: "assets/img2.png",
    backgroundColor: Color(0xffF69383),
  ));

  // 3
  specialities.add(SpecialityModel(
    noOfDoctors: 27,
    speciality: "Diabetes Care",
    imgAssetPath: "assets/img3.png",
    backgroundColor: Color(0xffEACBCB),
  ));

  return specialities;
}
