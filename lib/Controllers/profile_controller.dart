import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileController with ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<bool> completeProfile({
    required String speciality,
    required String location,
    required String description,
    required int numberExperience,
    required int numberPatients,
  }) async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? role = prefs.getString("role")?.toUpperCase();

    if (email == null || role == null) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    String base64Image = "";
    if (_selectedImage != null) {
      List<int> imageBytes = _selectedImage!.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    }

    ProfileModel profile = ProfileModel(
      email: email,
      speciality: speciality,
      location: location,
      description: description,
      numberExperience: numberExperience,
      numberPatients: numberPatients,
      photo: base64Image,
    );

    bool success = await _profileService.completeProfile(profile, role);

    _isLoading = false;
    notifyListeners();

    return success;
  }
}
