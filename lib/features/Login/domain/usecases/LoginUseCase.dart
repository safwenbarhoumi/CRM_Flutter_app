import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../entities/LoginEntity.dart';
import '../repositories/LoginRepository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    return await repository.login(params);
  }
}
