import 'package:fitness_app/presentation/widgets/article_card_for_homepage.dart';
import 'package:fitness_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:fitness_app/presentation/widgets/recommendation_cart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(66, 66, 66, 1),
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Madison',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE0C3FC)),
              ),
              SizedBox(height: 4),
              Text(
                "It's Time To Challenge Your Limits.",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: const [
            Icon(Icons.search, color: Color(0xFFE0C3FC)),
            SizedBox(width: 20),
            Icon(Icons.notifications, color: Color(0xFFE0C3FC)),
            SizedBox(width: 20),
            Icon(Icons.person, color: Color(0xFFE0C3FC)),
            SizedBox(width: 20),
          ],
          backgroundColor: Colors.grey[800],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recommendations',
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  RecommendationCard(
                    title: 'Squat Exercise',
                    duration: '12 Minutes',
                    kcal: '120 Kcal',
                    imagePath: 'assets/images/recoment picture 1.png',
                  ),
                  SizedBox(width: 10),
                  RecommendationCard(
                    title: 'Full Body Stretching',
                    duration: '12 Minutes',
                    kcal: '120 Kcal',
                    imagePath: 'assets/images/recoment picture 2.png',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0C3FC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 30.0),
                    child: Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weekly\nChallenge',
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Plank With Hip Twist',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Image.asset(
                          "assets/images/challenge picture 1.png",
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    right: 20,
                    top: -20,
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Articles & Tips',
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  ArticleCardForHome(
                    title: 'Supplement Guide',
                    imagePath: 'assets/images/article picture 1.png',
                  ),
                  SizedBox(width: 10),
                  ArticleCardForHome(
                    title: '15 Quick & Effective Daily Routines',
                    imagePath: 'assets/images/article picture 2.png',
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar());
  }
}
