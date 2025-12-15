import 'package:flutter/material.dart';
import 'news_cache.dart';
import 'news_detail_page.dart';

class NewsListPage extends StatefulWidget {
  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    NewsCache.loadNews().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final articles = NewsCache.articles;
    return Scaffold(
      body: articles.isEmpty
          ? const Center(
              child: Text(
                'Không có bài viết hợp lệ',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final a = articles[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.network(
                      a.imageUrl,
                      width: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                    title: Text(
                      a.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      a.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsDetailPage(article: a),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
