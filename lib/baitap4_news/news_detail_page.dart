import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/article.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết bài viết')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.imageUrl),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(article.description),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Mở bài viết gốc'),
              onPressed: () {
                launchUrl(
                  Uri.parse(article.url),
                  mode: LaunchMode.externalApplication,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
