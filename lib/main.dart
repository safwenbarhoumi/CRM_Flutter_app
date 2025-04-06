import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happytech_clean_architecture/core/databases/cache/cache_helper.dart';
import 'Controllers/booking.dart';
import 'Controllers/chatController.dart';
import 'Controllers/loginController.dart';
import 'Controllers/profile_controller.dart';
import 'Controllers/signup_provider.dart';
import 'Views/NavigationBottomBar.dart';
import 'Views/ProfileScreen.dart';
import 'Views/SignUpSreen/SignuUp_Sreen.dart';
import 'Views/Skip.dart';
import 'core/databases/api/dio_consumer.dart';

import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();

  String? email = CacheHelper().getDataString(key: 'email');
  print("**********************");
  print('Cached email: $email');
  print("***********************");

  runApp(
    MyApp(initialRoute: email != null && email.isNotEmpty ? '/home' : '/'),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      // 🧩 Ajouté ici
      builder: (context, orientation, deviceType) {
        return ScreenUtilInit(
          designSize: const Size(411, 823),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MultiProvider(
              providers: [
                Provider<DioConsumer>(create: (_) => DioConsumer(dio: Dio())),
                ChangeNotifierProvider(create: (context) => SignUpProvider()),
                ChangeNotifierProvider(create: (context) => LoginController()),
                ChangeNotifierProvider(create: (_) => ProfileController()),
                ChangeNotifierProvider(create: (_) => ChatController()),
                ChangeNotifierProvider(create: (_) => BookingController()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                routes: {
                  '/': (context) => Skip(),
                  '/profile': (context) => ProfileScreen(),
                  '/home': (context) => NavigationBottomBar(),
                  '/signup': (context) => Register(),
                },
                initialRoute: initialRoute,
              ),
            );
          },
        );
      },
    );
  }
}
