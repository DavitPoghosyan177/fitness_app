import 'package:fitness_app/presentation/pages/articles_page/articles_page.dart';
import 'package:fitness_app/presentation/pages/workout_page/workout_videos_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
                    decoration: BoxDecoration(
              color: Colors.grey[800],),
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey, 
                indicator: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                tabs: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child:  Text(
                      'Workout Videos',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Articles & Tips',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body:  TabBarView(
          children: [
            WorkoutVideosPage(),
            ArticlesTipsPage(),
          ],
        ),
      ),
    );
  }
}
