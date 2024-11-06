import 'package:fitness_app/presentation/pages/articles_detail_page/article_detail_page.dart';
import 'package:fitness_app/presentation/widgets/article_card.dart';
import 'package:fitness_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:flutter/material.dart';

class ArticlesTipsPage extends StatelessWidget {
  const ArticlesTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                ArticleCard(
                  title: 'Strength Training Tips',
                  imageAsset: 'assets/images/article picture 2.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArticleDetailPage(
                          title: 'Strength Training Tips',
                          imageAsset: 'assets/images/article picture 2.png',
                          content:
                              'Discover essential Strength Training Tips...',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ArticleCard(
                  title: 'Healthy Weight Loss',
                  imageAsset: 'assets/images/article picture 1.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArticleDetailPage(
                          title: 'Healthy Weight Loss',
                          imageAsset: 'assets/images/article picture 1.png',
                          content:
                              'Learn effective and sustainable weight loss strategies...',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                // Additional ArticleCards...
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
