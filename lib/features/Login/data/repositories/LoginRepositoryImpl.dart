import 'package:dartz/dartz.dart';
import '../../../../core/errors/expentions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../domain/entities/LoginEntity.dart';
import '../../domain/repositories/LoginRepository.dart';
import '../datasources/LoginLocalDataSource.dart';
import '../datasources/LoginRemoteDataSource.dart';
import '../models/LoginModel.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, LoginEntity>> login(LoginParams params) async {
    try {
      final loginData = LoginModel(
        email: params.email,
        password: params.password,
      );
      final remoteResponse = await remoteDataSource.login(loginData);
      localDataSource.cacheLoginData(remoteResponse);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errorMessage));
    } on CacheException catch (e) {
      return Left(Failure(errMessage: e.errorMessage));
    }
  }
}
