import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/params/params.dart';
import '../../domain/usecases/LoginUseCase.dart';
import '../screens/LoginState.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    final params = LoginParams(
      email: email,
      password: password,
    );
    final result = await loginUseCase(params);
    result.fold(
      (failure) => emit(LoginFailure(failure.errMessage)),
      (loginData) => emit(LoginSuccess(loginData)),
    );
  }
}
