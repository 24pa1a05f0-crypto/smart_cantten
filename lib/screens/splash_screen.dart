import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 24, 26, 28),
          child: Column(
            children: [
              const Spacer(),
              Container(
                height: 94,
                width: 94,
                decoration: BoxDecoration(
                  color: AppTheme.paleOrange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.ramen_dining_rounded,
                    color: AppTheme.orange, size: 52),
              ),
              const SizedBox(height: 22),
              const Text(
                'Smart Canteen',
                style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    color: AppTheme.ink),
              ),
              const SizedBox(height: 9),
              const Text(
                'Good food, less waiting.',
                style: TextStyle(fontSize: 15, color: AppTheme.muted),
              ),
              const SizedBox(height: 15),
              const Text(
                'A simpler way to order your campus favourites.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13, height: 1.45, color: AppTheme.muted),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Explore the canteen',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 13),
              const Text('STUDENT DEMO · STAGE 1',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppTheme.muted)),
            ],
          ),
        ),
      ),
    );
  }
}
