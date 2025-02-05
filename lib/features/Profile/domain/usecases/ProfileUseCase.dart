import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/ProfileEntity.dart';
import '../repositories/ProfileRepository.dart';


class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase({required this.repository});

  Future<Either<Failure, ProfileEntity>> getProfile() async {
    return await repository.getProfile();
  }

  Future<Either<Failure, ProfileEntity>> updateProfile(
      ProfileEntity profileData) async {
    return await repository.updateProfile(profileData);
  }
}
