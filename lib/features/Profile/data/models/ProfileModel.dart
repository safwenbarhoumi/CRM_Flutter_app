import 'package:happytech_clean_architecture/features/Profile/domain/entities/ProfileEntity.dart';

class ProfileModel extends ProfileEntity {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String photo;
  final String actualJob;
  final String address;
  final bool darkMode;

  // ProfileModel constructor calling ProfileEntity constructor
  ProfileModel({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.photo,
    required this.actualJob,
    required this.address,
    required this.darkMode,
  }) : super(
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          photo: photo,
          actualJob: actualJob,
          address: address,
          darkMode: darkMode,
        );

  // Factory constructor to create ProfileModel from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      photo: json['photo'],
      actualJob: json['actualJob'],
      address: json['address'],
      darkMode: json['darkMode'],
    );
  }

  // Method to convert ProfileModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'photo': photo,
      'actualJob': actualJob,
      'address': address,
      'darkMode': darkMode,
    };
  }

  // Convert ProfileModel to ProfileEntity
  ProfileEntity toEntity() {
    return ProfileEntity(
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      photo: photo,
      actualJob: actualJob,
      address: address,
      darkMode: darkMode,
    );
  }
}
