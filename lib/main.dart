import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happytech_clean_architecture/core/databases/cache/cache_helper.dart';
import 'package:happytech_clean_architecture/features/user/presentation/cubit/user_cubit.dart';
import 'package:happytech_clean_architecture/features/user/presentation/screens/user_screen.dart';

import 'core/databases/api/dio_consumer.dart';
import 'features/Signup/data/datasources/SignupLocalDataSource.dart';
import 'features/Signup/data/datasources/SignupRemoteDataSource .dart';
import 'features/Signup/data/repositories/SignupRepositoryImpl.dart';
import 'features/Signup/domain/usecases/SignupUseCase.dart';
import 'features/Signup/presentation/cubit/SignupCubit.dart';
import 'features/Signup/presentation/screens/SignupScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Créer une instance de SignupUseCase
    final signupUseCase = SignupUseCase(
      repository: SignupRepositoryImpl(
        remoteDataSource: SignupRemoteDataSource(api: DioConsumer(dio: Dio())),
        localDataSource: SignupLocalDataSource(cache: CacheHelper()),
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupCubit(
              signupUseCase: signupUseCase), // Injecter SignupUseCase
        ),
        BlocProvider(
          create: (context) => UserCubit()..eitherFailureOrUser(1),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/aaa': (context) => const UserScreen(),
          '/': (context) => SignupScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}
