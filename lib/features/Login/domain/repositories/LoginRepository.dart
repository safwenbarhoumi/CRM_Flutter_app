import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../entities/LoginEntity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login(LoginParams params);
}
