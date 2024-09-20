import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage2 extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  OnboardingPage2({required this.currentPage, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/gym women second.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height  * 0.344,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFC6A0E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/Nutrition.svg',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Find nutrition tips that fit your lifestyle   ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  
                  // Add the dots to the same column
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      totalPages,
                      (index) => buildDot(index),
                    ),
                  ),
                  SizedBox(height: 40)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10,
      width: currentPage == index ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}
