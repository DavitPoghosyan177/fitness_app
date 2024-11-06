import 'package:flutter/material.dart';

class ArticleCardForHome extends StatelessWidget {
  final String title;
  final String imagePath;

  const ArticleCardForHome({
    required this.title,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(color: Colors.yellow, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}