import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../domain/entities/ProfileEntity.dart';
import '../cubit/ProfileCubit.dart';
import '../cubit/ProfileState.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _actualJobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isDarkMode = false;
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
          title: Text(
            "Logout",
            style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Are you sure you want to log out?",
            style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: _isDarkMode ? Colors.blue[300] : Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle logout logic here
              },
              child: Text(
                "Logout",
                style: TextStyle(
                    color: _isDarkMode ? Colors.red[300] : Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isDarkMode ? Colors.black : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black;
    final fieldColor = _isDarkMode ? Colors.grey[800] : Colors.grey[200];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: textColor),
            onPressed: _toggleDarkMode,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: _confirmLogout,
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Failed to load data: ${state.errMessage}")),
              );
            }
          },
          builder: (context, state) {
            ProfileEntity profileData = ProfileEntity(
              fullName: "John Doe",
              phoneNumber: "+1234567890",
              email: "johndoe@example.com",
              photo: "https://via.placeholder.com/150",
              actualJob: "Software Engineer",
              address: "Unknown Address",
              darkMode: _isDarkMode,
            );

            if (state is ProfileSuccess) {
              profileData = state.profileData;
            }

            _fullNameController.text = profileData.fullName;
            _phoneNumberController.text = profileData.phoneNumber;
            _emailController.text = profileData.email;
            _actualJobController.text = profileData.actualJob;
            _addressController.text = profileData.address;

            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : NetworkImage(profileData.photo)
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child:
                                  const Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                      "Full Name", _fullNameController, textColor, fieldColor),
                  _buildTextField("Phone Number", _phoneNumberController,
                      textColor, fieldColor),
                  _buildTextField(
                      "Email", _emailController, textColor, fieldColor),
                  _buildTextField("Current Job", _actualJobController,
                      textColor, fieldColor),
                  _buildTextField(
                      "Address", _addressController, textColor, fieldColor),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedProfile = ProfileEntity(
                          fullName: _fullNameController.text,
                          phoneNumber: _phoneNumberController.text,
                          email: _emailController.text,
                          photo: profileData.photo,
                          actualJob: _actualJobController.text,
                          address: _addressController.text,
                          darkMode: profileData.darkMode,
                        );
                        context
                            .read<ProfileCubit>()
                            .updateProfile(updatedProfile);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Update Profile',
                        style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      Color textColor, Color? fieldColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: textColor),
          filled: true,
          fillColor: fieldColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: TextStyle(color: textColor),
      ),
    );
  }
}
