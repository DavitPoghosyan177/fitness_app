import 'package:fitness_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String imageAsset;
  final String content;

  const ArticleDetailPage({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.content,
  });

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
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.yellow,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Published On September 15',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageAsset,
                  fit: BoxFit.fitHeight,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                content,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              buildTipSection(
                'Plan Your Routine:',
                'Before starting any workout, plan your routine for the week. Focus on different muscle groups on different days to allow for adequate rest and recovery.',
              ),
              buildTipSection(
                'Warm-Up:',
                'Begin your workout with a proper warm-up session. This could include light cardio exercises like jogging or jumping jacks, as well as dynamic stretches to prepare your muscles for the upcoming workout.',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar());
  }

  Widget buildTipSection(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.yellow,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
