import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happytech_clean_architecture/core/databases/cache/cache_helper.dart';
import 'package:happytech_clean_architecture/features/user/presentation/cubit/user_cubit.dart';
import 'package:happytech_clean_architecture/features/user/presentation/screens/user_screen.dart';

import 'core/databases/api/dio_consumer.dart';
import 'features/Login/data/datasources/LoginLocalDataSource.dart';
import 'features/Login/data/datasources/LoginRemoteDataSource.dart';
import 'features/Login/data/repositories/LoginRepositoryImpl.dart';
import 'features/Login/domain/usecases/LoginUseCase.dart';
import 'features/Login/presentation/cubit/LoginCubit.dart';
import 'features/Login/presentation/screens/LoginScreen.dart';
import 'features/Signup/data/datasources/SignupLocalDataSource.dart';
import 'features/Signup/data/datasources/SignupRemoteDataSource .dart';
import 'features/Signup/data/repositories/SignupRepositoryImpl.dart';
import 'features/Signup/domain/usecases/SignupUseCase.dart';
import 'features/Signup/presentation/cubit/SignupCubit.dart';
import 'features/Signup/presentation/screens/SignupScreen.dart';
import 'features/SplashScreen/splashScreen.dart';
import 'features/bottomNavBar/bottomNavigationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an instance of SignupUseCase
    final signupUseCase = SignupUseCase(
      repository: SignupRepositoryImpl(
        remoteDataSource: SignupRemoteDataSource(api: DioConsumer(dio: Dio())),
        localDataSource: SignupLocalDataSource(cache: CacheHelper()),
      ),
    );

    // Create an instance of LoginUseCase and its dependencies
    final loginUseCase = LoginUseCase(
      repository: LoginRepositoryImpl(
        remoteDataSource: LoginRemoteDataSource(api: DioConsumer(dio: Dio())),
        localDataSource: LoginLocalDataSource(cache: CacheHelper()),
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupCubit(signupUseCase: signupUseCase),
        ),
        BlocProvider(
          create: (context) => UserCubit()..eitherFailureOrUser(1),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(loginUseCase: loginUseCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(), // Écran de démarrage
          '/signup': (context) => SignupScreen(), // Écran d'inscription
          '/login': (context) => LoginScreen(), // Écran de connexion
          '/user': (context) => const UserScreen(), // Écran utilisateur
          '/home': (context) =>
              const BottomNavigationScreen(), // Écran principal avec Bottom Navigation Bar
        },
        initialRoute: '/', // Route initiale
      ),
    );
  }
}
