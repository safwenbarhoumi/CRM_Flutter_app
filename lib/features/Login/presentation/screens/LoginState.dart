import '../../domain/entities/LoginEntity.dart';

class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginEntity loginData;

  LoginSuccess(this.loginData);
}

class LoginFailure extends LoginState {
  final String errMessage;

  LoginFailure(this.errMessage);
}
