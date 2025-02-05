import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'splashCubit.dart';
import 'splashState.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            Navigator.pushReplacementNamed(context, '/signup');
          }
        },
        child: const SplashView(),
      ),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Logo
              Image.asset(
                'assets/logo/crm.png',
                width: 250,
                height: 250,
              ).animate().fadeIn(duration: 1.seconds).scale(),

              const SizedBox(height: 20),

              // Animated Text
              Text(
                "Welcome to FD Conseil Pro",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn(delay: 500.ms).slideX(),

              const SizedBox(height: 5),

              // Subtitle Text with Typing Effect
              Animate(
                effects: [FadeEffect(), SlideEffect()],
                delay: 1.seconds,
                child: Text(
                  "Your professional writing assistant",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
