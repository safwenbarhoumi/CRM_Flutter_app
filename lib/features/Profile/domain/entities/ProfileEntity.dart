class ProfileEntity {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String photo;
  final String actualJob;
  final String address;
  final bool darkMode;

  // Required constructor
  ProfileEntity({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.photo,
    required this.actualJob,
    required this.address,
    required this.darkMode,
  });
}
