import 'package:fitness_app/presentation/pages/resources_page/resources_page.dart';
import 'package:fitness_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoViewPage extends StatelessWidget {
  final String videoUrl;  

  const VideoViewPage({required this.videoUrl, super.key});  

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: false,
      ),
    );

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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ResourcesScreen(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView( 
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 110),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              decoration: const BoxDecoration(
                color: Color(0xFFE0C3FC),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  YoutubePlayer(
                    controller: controller,
                    showVideoProgressIndicator: true,
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
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
