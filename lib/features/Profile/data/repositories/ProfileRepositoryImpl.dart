import 'package:dartz/dartz.dart';
import '../../../../core/errors/expentions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/ProfileEntity.dart';
import '../../domain/repositories/ProfileRepository.dart';
import '../datasources/ProfileLocalDataSource.dart';
import '../datasources/ProfileRemoteDataSource.dart';
import '../models/ProfileModel.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      // Fetch profile data from remote
      final profileModel = await remoteDataSource.getProfile();

      // Convert ProfileModel to ProfileEntity
      final profileEntity = ProfileEntity(
        fullName: profileModel.fullName,
        phoneNumber: profileModel.phoneNumber,
        email: profileModel.email,
        photo: profileModel.photo,
        actualJob: profileModel.actualJob,
        address: profileModel.address,
        darkMode: profileModel.darkMode,
      );

      // Cache the profile data
      localDataSource.cacheProfileData(profileModel);

      // Return the ProfileEntity
      return Right(profileEntity);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
      ProfileEntity profileData) async {
    try {
      // Convert ProfileEntity to ProfileModel
      final profileModel = ProfileModel(
        fullName: profileData.fullName,
        phoneNumber: profileData.phoneNumber,
        email: profileData.email,
        photo: profileData.photo,
        actualJob: profileData.actualJob,
        address: profileData.address,
        darkMode: profileData.darkMode,
      );

      // Update profile on remote server
      final updatedProfile = await remoteDataSource.updateProfile(profileModel);

      // Cache the updated profile data
      localDataSource.cacheProfileData(updatedProfile);

      // Return the updated ProfileEntity
      return Right(updatedProfile);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errorMessage));
    }
  }
}
