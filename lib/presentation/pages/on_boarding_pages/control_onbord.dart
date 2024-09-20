import 'package:fitness_app/presentation/pages/home_page/home_page.dart';
import 'package:fitness_app/presentation/pages/on_boarding_pages/first_onbord_page.dart';
import 'package:fitness_app/presentation/pages/on_boarding_pages/second_onbord_page.dart';
import 'package:fitness_app/presentation/pages/on_boarding_pages/third_onbord_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage1(currentPage: _currentPage, totalPages: 3),
              OnboardingPage2(currentPage: _currentPage, totalPages: 3),
              OnboardingPage3(currentPage: _currentPage, totalPages: 3),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: _currentPage != 2
                ? TextButton(
                    onPressed: () {
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      bottomSheet: Builder(
        builder: (context) {
          if (_currentPage == 2) {
            return IconButton(
              
                  icon: const Text("Get Started"),
                  iconSize: 80,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('onboardingFinished', true);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  },
                );
              
          } else {
            return const SizedBox(height: 60);
          }
        },
      ),
    );
  }
}
