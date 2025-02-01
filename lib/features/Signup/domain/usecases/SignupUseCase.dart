import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../entities/SignupEntity.dart';
import '../repositories/SignupRepository.dart';

class SignupUseCase {
  final SignupRepository repository;

  SignupUseCase({required this.repository});

  Future<Either<Failure, SignupEntity>> call(SignupParams params) async {
    return await repository.signup(params);
  }
}
