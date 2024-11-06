import 'package:fitness_app/presentation/pages/video_view_page/video_view_page.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final String duration;
  final String kcal;
  final String imagePath;

  const RecommendationCard({
    required this.title,
    required this.duration,
    required this.kcal,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 10,
                  bottom: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VideoViewPage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.play_circle_fill,
                      color: Color.fromARGB(255, 224, 216, 216),
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.yellow, fontSize: 16),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Color(0xFFE0C3FC), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department, color: Color(0xFFE0C3FC), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        kcal,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}