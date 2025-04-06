import 'dart:convert';

/// Model representing a doctor's information.
class DoctorInformationModel {
  final String? image;
  final String title;
  final String firstName;
  final String lastName;
  final String? specialist;
  final double star;
  final String? description;
  final int? nExperience;
  final int? nPatient;
  final String location;
  // final String? email;

  DoctorInformationModel({
    this.image,
    required this.title,
    required this.firstName,
    required this.lastName,
    this.specialist,
    required this.star,
    this.description,
    this.nExperience,
    this.nPatient,
    required this.location,
    // required this.email,
  });

  /// Parses the JSON map and assigns default values where necessary.
  factory DoctorInformationModel.fromJson(Map<String, dynamic> json) {
    print("Raw doctor JSON: ${jsonEncode(json)}");
    return DoctorInformationModel(
      image: json['photo'] as String?,
      title: json['name'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      specialist: json['specialty'] as String?,
      description: json['description'] as String? ?? 'No description yet',
      star: (json['numberRating'] as num?)?.toDouble() ?? 0.0,
      nExperience: json['numberExperience'] as int?,
      nPatient: json['numberPatients'] as int?,
      location: json['location'] as String? ?? '',
      // email: json['email'] as String?, // optional fix if needed later
    );
  }
}

/*class DoctorInformationModel {
  final String id;
  final String image;
  final String title;
  final String specialist;
  final String hospital;
  final String star;

  DoctorInformationModel({
    required this.id,
    required this.image,
    required this.title,
    required this.specialist,
    required this.hospital,
    required this.star,
  });
}*/
