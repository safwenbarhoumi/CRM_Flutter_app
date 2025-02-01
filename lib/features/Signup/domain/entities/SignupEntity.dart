class SignupEntity {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final String confirmPassword;

  SignupEntity({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
