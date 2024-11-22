import 'package:fitness_app/presentation/logic/media/media_bloc.dart';
import 'package:fitness_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:fitness_app/presentation/widgets/recommendation_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutVideosPage extends StatelessWidget {
  const WorkoutVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: BlocConsumer<MediaBloc, MediaState>(
          listener: (context, state) {
            if (state is VideoErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error, style: const TextStyle(color: Colors.red))),
              );
            }
          },
          builder: (context, state) {
            if (state is VideoLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VideoErrorState) {
              return Center(
                child: Text(state.error, style: const TextStyle(color: Colors.red)),
              );
            }
            return buildContent(state.videos); 
          },
        ),
        bottomNavigationBar: const BottomNavBar(),
      );
  }

  Widget buildContent(List<Map<String, dynamic>> videos) {
    return Padding(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final data = videos[index];
                return RecommendationCard(
                  title: data['title'] ?? '',
                  duration: 'Duration info here',  
                  kcal: '5 Exercises', 
                  videoUrl: data['video_url'] ?? 'assets/images/default.png',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
