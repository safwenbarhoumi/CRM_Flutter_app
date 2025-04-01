import 'package:flutter/material.dart';
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
      print("Données reçues : $data"); // 🔍 DEBUG
      setState(() {
        doctorInformations = data;
      });
    } catch (e) {
      print("❌ Erreur lors de la récupération des données : $e");
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
              DoctorImage(
                  doctorInformationModel: widget.doctorInformationModel),
              DoctorDescription(
                  doctorInformationModel: widget.doctorInformationModel),
            ],
          ),
        ),
      ),
    );
  }
}
