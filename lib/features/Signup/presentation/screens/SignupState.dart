import '../../domain/entities/SignupEntity.dart';

class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final SignupEntity signupData;

  SignupSuccess(this.signupData);
}

class SignupFailure extends SignupState {
  final String errMessage;

  SignupFailure(this.errMessage);
}
