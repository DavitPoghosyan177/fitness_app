import 'package:fitness_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:fitness_app/presentation/widgets/recommendation_cart.dart';
import 'package:flutter/material.dart';

class WorkoutVideosPage extends StatelessWidget {
  
  final List<Map<String, String>> workoutData = [
    {
     'title': 'Strength Training',
      'duration': '45 Minutes',
      'kcal': '5 Exercises',
      'imagePath': 'assets/images/recoment picture 1.png',
    },
    {
       'title': 'Strength Training',
      'duration': '45 Minutes',
      'kcal': '5 Exercises',
      'imagePath': 'assets/images/recoment picture 1.png',
    },
    {
       'title': 'Strength Training',
      'duration': '45 Minutes',
      'kcal': '5 Exercises',
      'imagePath': 'assets/images/recoment picture 1.png',
    },
    {
      'title': 'Strength Training',
      'duration': '45 Minutes',
      'kcal': '5 Exercises',
      'imagePath': 'assets/images/recoment picture 1.png',
    },
    {
      'title': 'Strength Training',
      'duration': '45 Minutes',
      'kcal': '5 Exercises',
      'imagePath': 'assets/images/recoment picture 1.png',
    },
    {
    'title': 'Strength Training',
      'duration': '45 Minutes',
      'kcal': '5 Exercises',
      'imagePath': 'assets/images/recoment picture 1.png',
    },
  ];

  WorkoutVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              const Text(
              'Quick & Easy Workout Videos',
              style: TextStyle(color: Colors.limeAccent, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Discover Fresh Workouts: Elevate Your Training',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: workoutData.length,
                itemBuilder: (context, index) {
                  final data = workoutData[index];
                  return RecommendationCard(
                    title: data['title']!,
                    duration: data['duration']!,
                    kcal: data['kcal']!,
                    imagePath: data['imagePath']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar()
    );
  }
}
