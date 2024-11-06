import 'package:fitness_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:flutter/material.dart';

class VideoViewPage extends StatelessWidget {
  const VideoViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
          title: const Text(
            'Resources',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE0C3FC),
            ),
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
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin:  const EdgeInsets.symmetric(vertical: 110),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              decoration: const BoxDecoration(
                color: Color(0xFFE0C3FC),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/gym men first.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 112, 36, 126),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.play_arrow,
                            color: Colors.white, size: 50),
                        onPressed: () {
                        },
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 16,
                    right: 16,
                    child: Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
