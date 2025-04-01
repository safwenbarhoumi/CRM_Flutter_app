import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/profile_model.dart';
import '../Services/profile_service.dart';
import '../controllers/profile_controller.dart';
import 'package:http/http.dart' as http;

class CompleteProfile extends StatefulWidget {
  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController specialityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController patientsController = TextEditingController();

  File? selectedImage;
  bool isLoading = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> completeProfile(String email, String specialty, String location,
      String description, int numberExperience, int numberPatients) async {
    final url = Uri.parse(
        'http://192.168.1.104:8091/doctor/complete-profile?email=$email'); // Using query param for email

    final Map<String, dynamic> profileData = {
      'specialty': specialty,
      'location': location,
      'description': description,
      'numberExperience': numberExperience,
      'numberPatients': numberPatients,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(profileData), // Send the rest of the data in the body
    );

    if (response.statusCode == 200) {
      print('Profile updated successfully!');
    } else {
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete Your Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundImage:
                      selectedImage != null ? FileImage(selectedImage!) : null,
                  child: selectedImage == null
                      ? Icon(Icons.person, size: 50.sp)
                      : null,
                ),
              ),
              SizedBox(height: 20.h),
              buildTextField("Speciality", specialityController),
              buildTextField("Location", locationController),
              buildTextField("Description", descriptionController, maxLines: 3),
              buildTextField("Years of Experience", experienceController,
                  keyboardType: TextInputType.number),
              buildTextField("Number of Patients", patientsController,
                  keyboardType: TextInputType.number),
              SizedBox(height: 20.h),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(),
              /*ElevatedButton(
                      onPressed: completeProfile,
                      child: Text("Complete Profile"),
                    ),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }
}
