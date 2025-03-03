import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happytech_clean_architecture/core/databases/cache/cache_helper.dart';
import 'Views/NavigationBottomBar.dart';
import 'Views/ProfileScreen.dart';
import 'Views/Skip.dart';
import 'Views/register.dart';
import 'core/databases/api/dio_consumer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 823),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            Provider<DioConsumer>(create: (_) => DioConsumer(dio: Dio())),
            // Add other providers here
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => Skip(),
              '/profile': (context) => ProfileScreen(),
              '/home': (context) => NavigationBottomBar(),
              '/signup': (context) => Register(),
            },
            initialRoute: '/',
          ),
        );
      },
    );
  }
}
