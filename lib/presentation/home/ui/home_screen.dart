import 'package:flutter/material.dart';
import '../../../app/app.dart';

/// Home Screen - Placeholder for the main home screen
/// This can be replaced with your actual home screen implementation
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: ColorManager.primaryColorLight,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 64,
              color: ColorManager.primaryColorLight,
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to Home Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This is a placeholder home screen.',
              style: TextStyle(
                fontSize: 16,
                color: ColorManager.hintColorLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
