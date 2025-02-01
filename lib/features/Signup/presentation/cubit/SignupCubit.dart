import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../domain/usecases/SignupUseCase.dart';
import '../screens/SignupState.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;

  SignupCubit({required this.signupUseCase}) : super(SignupInitial());

  void signup(String fullName, String phoneNumber, String email,
      String password, String confirmPassword) async {
    emit(SignupLoading());
    final params = SignupParams(
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    final result = await signupUseCase(params);
    result.fold(
      (failure) => emit(SignupFailure(failure.errMessage)),
      (signupData) => emit(SignupSuccess(signupData)),
    );
  }
}
