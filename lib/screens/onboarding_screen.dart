import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isBlackPage = _currentPage == 0;

    return Scaffold(
      backgroundColor: isBlackPage ? Colors.black : Colors.white,
      body: Container(
        color: isBlackPage ? Colors.black : Colors.white,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  _buildLogoPage(),
                  _buildPage(
                    title: "Track. Reflect. Grow.",
                    subtitle:
                        "Visualize your spending habits and stay mindful every day.",
                    color: Colors.white,
                    icon: Icons.insights,
                  ),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: WormEffect(
                dotColor: isBlackPage ? Colors.grey[600]! : Colors.grey,
                activeDotColor: isBlackPage ? Colors.white : Colors.black,
                spacing: 8,
                radius: 8,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
            const SizedBox(height: 20),
            _currentPage == 1
                ? ElevatedButton(
                    onPressed: () => Get.offAll(() => const HomeScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text("Get Started"),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ✅ Logo page with swipe-up action
  Widget _buildLogoPage() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Centered Logo + Title
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/Tm.png",
                  width: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                const Text(
                  "Track Your Mind, Save Your Money",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // ✅ Bottom swipe-up button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                const SizedBox(height: 4),
                const Text(
                  'Swipe right to continue',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Normal page builder
  Widget _buildPage({
    String? title,
    String? subtitle,
    Color? color,
    IconData? icon,
  }) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: 120, color: Colors.black),
          const SizedBox(height: 32),
          Text(
            title ?? "",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle ?? "",
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
