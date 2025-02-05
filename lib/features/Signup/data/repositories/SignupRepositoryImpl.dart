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
      );

      final remoteResponse = await remoteDataSource.signup(signupData);
      print("remoteResponse from IMPL: $remoteResponse");

      // Ensure signup data is cached
      // await localDataSource.cacheSignupData(remoteResponse);

      return Right(remoteResponse);
    } on ServerException catch (e) {
      print("ServerException occurred.");
      return Left(
          Failure(errMessage: "Erreur du serveur, veuillez réessayer."));
    } catch (e) {
      print("Unexpected Error: $e");
      return Left(Failure(errMessage: ""));
    }
  }
}
