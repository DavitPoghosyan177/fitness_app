import 'package:fitness_app/presentation/logic/media/media_bloc.dart';
import 'package:fitness_app/presentation/pages/articles_detail_page/article_detail_page.dart';
import 'package:fitness_app/presentation/pages/video_view_page/video_view_page.dart';
import 'package:fitness_app/presentation/widgets/article_card_for_homepage.dart';
import 'package:fitness_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:fitness_app/presentation/widgets/recommendation_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                color: Color(0xFFE0C3FC),
              ),
            ),
            SizedBox(height: 4),
            Text(
              "It's Time To Challenge Your Limits.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
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
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            BlocConsumer<MediaBloc, MediaState>(
              listener: (context, state) {
                if (state is VideoErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error,
                          style: const TextStyle(color: Colors.red)),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is VideoLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                  return Column(
                    children: [
                      Row(
                        children: [
                          for (var i = 0; i < state.videos.length && i < 2; i++)
                            RecommendationCard(
                              title: state.videos[i]['title'] ?? '',
                              duration: 'Duration info here',
                              kcal: '5 Exercises',
                              videoUrl: state.videos[i]['video_url'] ??
                                  'assets/images/default.png',
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
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Plank With Hip Twist',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                          Positioned(
                            right: 20,
                            top: -20,
                            child: GestureDetector(
                              onTap: () {
                                if (state.videos.isNotEmpty) {
                                  String videoUrl = state.videos[0]
                                          ['video_url'] ??
                                      'assets/images/default.png';
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VideoViewPage(videoUrl: videoUrl),
                                    ),
                                  );
                                }
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
                    ],
                  );
                              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Articles & Tips',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<MediaBloc, MediaState>(
              builder: (context, state) {
                if (state is ArticleLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ArticleLoadedState) {
                  return Row(
                    children: [
                      for (var i = 0; i < state.articles.length && i < 2; i++)
                        ArticleCardForHome(
                          title: state.articles[i]['title'] ?? '',
                          imagePath: state.articles[i]['image_url'] ?? '',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(
                                  title: state.articles[i]['title'] ?? '',
                                  imageAsset:
                                      state.articles[i]['image_url'] ?? '',
                                  content:
                                      state.articles[i]['description'] ?? '',
                                ),
                              ),
                            );
                          },
                        ),
                      const SizedBox(width: 10),
                    ],
                  );
                } else if (state is ArticleErrorState) {
                  return Center(
                      child: Text('Failed to load articles: ${state.error}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
