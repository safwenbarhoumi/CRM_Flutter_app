import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../entities/SignupEntity.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupEntity>> signup(SignupParams params);
}
