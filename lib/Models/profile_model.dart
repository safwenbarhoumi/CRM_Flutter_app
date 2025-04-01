class ProfileModel {
  final String email;
  final String speciality;
  final String location;
  final String description;
  final int numberExperience;
  final int numberPatients;
  final String photo; // Base64 string

  ProfileModel({
    required this.email,
    required this.speciality,
    required this.location,
    required this.description,
    required this.numberExperience,
    required this.numberPatients,
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "speciality": speciality,
      "location": location,
      "description": description,
      "numberExperience": numberExperience,
      "numberPatients": numberPatients,
      "photo": photo,
    };
  }
}
