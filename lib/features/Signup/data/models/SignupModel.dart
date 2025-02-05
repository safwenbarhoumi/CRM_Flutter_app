import '../../domain/entities/SignupEntity.dart';

class SignupModel extends SignupEntity {
  SignupModel({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) : super(
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
        );

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
    };
  }
}
