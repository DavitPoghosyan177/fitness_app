import 'package:fitness_app/presentation/logic/media/media_bloc.dart';
import 'package:fitness_app/presentation/pages/articles_detail_page/article_detail_page.dart';
import 'package:fitness_app/presentation/widgets/article_card.dart';
import 'package:fitness_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlesTipsPage extends StatelessWidget {
  const ArticlesTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MediaBloc, MediaState>(
              builder: (context, state) {
                if (state is ArticleLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ArticleLoadedState) {
                  return ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];
                      return ArticleCard(
                        title: article['title'] ?? '',
                        imageAsset: article['image_url'] ?? '',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailPage(
                                title: article['title'] ?? '',
                                imageAsset: article['image_url'] ?? '',
                                content: article['description'] ?? '',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is ArticleErrorState) {
                  return Center(
                      child: Text('Failed to load articles: ${state.error}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
