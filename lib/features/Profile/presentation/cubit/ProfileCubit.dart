import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/ProfileEntity.dart';
import '../../domain/usecases/ProfileUseCase.dart';
import 'ProfileState.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit({required this.profileUseCase}) : super(ProfileInitial());

  void getProfile() async {
    emit(ProfileLoading());
    final result = await profileUseCase.getProfile();
    result.fold(
      (failure) => emit(ProfileFailure(failure.errMessage)),
      (profileData) => emit(ProfileSuccess(profileData)),
    );
  }

  void updateProfile(ProfileEntity profileData) async {
    emit(ProfileLoading());
    final result = await profileUseCase.updateProfile(profileData);
    result.fold(
      (failure) => emit(ProfileFailure(failure.errMessage)),
      (profileData) => emit(ProfileSuccess(profileData)),
    );
  }
}
