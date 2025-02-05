import '../../domain/entities/ProfileEntity.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileEntity profileData;

  ProfileSuccess(this.profileData);
}

class ProfileFailure extends ProfileState {
  final String errMessage;

  ProfileFailure(this.errMessage);
}
