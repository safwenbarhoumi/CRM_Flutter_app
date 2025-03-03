import 'package:flutter/material.dart';

import '../data/doctor_information_data.dart';
import '../model/doctor_information_model.dart';
import '../widgets/doctor_description.dart';
import '../widgets/doctor_image.dart';

class DoctorScreen extends StatelessWidget {
  final List<DoctorInformationModel> doctorInformations = doctorInformation;
  final DoctorInformationModel doctorInformationModel;

  DoctorScreen({
    Key? key,
    required this.doctorInformationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorImage(doctorInformationModel: doctorInformationModel),
              DoctorDescription(doctorInformationModel: doctorInformationModel),
            ],
          ),
        ),
      ),
    );
  }
}
