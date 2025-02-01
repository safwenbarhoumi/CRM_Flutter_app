import '../../domain/entities/SignupEntity.dart';

class SignupModel extends SignupEntity {
  SignupModel({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
    required String confirmPassword,
  }) : super(
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        );

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
