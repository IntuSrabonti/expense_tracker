import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Get.offAll(() => const OnboardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // ✅ পুরো স্ক্রিন কালো
      body: Center(
        child: CircleAvatar(
          radius: 50, // ✅ লোগো ছোট গোলাকার আকারে থাকবে
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.asset("assets/icons/Tm.png", fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
