import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/ProfileEntity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile(
      ProfileEntity profileData);
}
