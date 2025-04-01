/// Model representing a doctor's information.
class DoctorInformationModel {
  final String id;
  final String? image;
  final String title;
  final String firstName;
  final String lastName;
  final String? specialist;
  final double star;
  final String? description;
  final int? nExperience;
  final int? nPatient;
  final String? location;

  /// Constructs a [DoctorInformationModel] with required and optional parameters.
  DoctorInformationModel({
    required this.id,
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
  });

  /// Factory constructor to create a [DoctorInformationModel] from a JSON map.
  /// Parses the JSON map and assigns default values where necessary.
  factory DoctorInformationModel.fromJson(Map<String, dynamic> json) {
    return DoctorInformationModel(
      id: json['id'] as String? ?? '',
      image: json['photo'] as String?,
      title: json['name'] ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      specialist: json['specialty'] as String?,
      description: json['description'] as String? ?? 'No description yet',
      star: (json['numberRating'] as num?)?.toDouble() ?? 0.0,
      nExperience: json['numberExperience'] as int?,
      nPatient: json['numberPatients'] as int?,
      location: json['location'] as String? ?? ' ',
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
