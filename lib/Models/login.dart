class LoginModel {
  final String id;
  final String email;
  final String password;
  final String role;

  LoginModel({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      password: '', // Ne pas stocker le mot de passe ici
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "role": role.toUpperCase(),
    };
  }
}
