import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/doctor_information_data.dart';
import '../model/doctor_information_model.dart';
import '../widgets/doctor_description.dart';
import '../widgets/doctor_image.dart';

class DoctorScreen extends StatefulWidget {
  final DoctorInformationModel doctorInformationModel;

  DoctorScreen({Key? key, required this.doctorInformationModel})
      : super(key: key);

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  List<DoctorInformationModel> doctorInformations = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      List<DoctorInformationModel> data = await fetchTop10Doctors();
      print("\uD83D\uDD0D Donn\u00e9es re\u00e7ues : $data");
      setState(() {
        doctorInformations = data;
      });
    } catch (e) {
      print(
          "\u274C Erreur lors de la r\u00e9cup\u00e9ration des donn\u00e9es : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              DoctorImage(
                  doctorInformationModel: widget.doctorInformationModel),
              SizedBox(height: 20.h),
              DoctorDescription(
                  doctorInformationModel: widget.doctorInformationModel),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
