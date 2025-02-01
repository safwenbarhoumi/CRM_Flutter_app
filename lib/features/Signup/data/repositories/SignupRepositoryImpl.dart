import 'package:dartz/dartz.dart';
import '../../../../core/errors/expentions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../domain/entities/SignupEntity.dart';
import '../../domain/repositories/SignupRepository.dart';
import '../datasources/SignupLocalDataSource.dart';
import '../datasources/SignupRemoteDataSource .dart';
import '../models/SignupModel.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource remoteDataSource;
  final SignupLocalDataSource localDataSource;

  SignupRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, SignupEntity>> signup(SignupParams params) async {
    try {
      final signupData = SignupModel(
        fullName: params.fullName,
        phoneNumber: params.phoneNumber,
        email: params.email,
        password: params.password,
        confirmPassword: params.confirmPassword,
      );
      final remoteResponse = await remoteDataSource.signup(signupData);
      localDataSource.cacheSignupData(remoteResponse);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: "Failed !"));
    }
  }
}
