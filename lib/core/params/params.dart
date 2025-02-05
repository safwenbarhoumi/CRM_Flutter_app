class TemplateParams {
  final String id;
  TemplateParams({required this.id});
}

class UserParams {
  final String id;
  UserParams({required this.id});
}

class PostParams {
  final String id;
  PostParams({required this.id});
}

class SignupParams {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;

  SignupParams({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
