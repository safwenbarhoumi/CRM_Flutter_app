class SignUpModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String role;

  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "password": password,
      "role": role,
    };
  }
}
