import 'package:flutter/material.dart';
import 'news_cache.dart';
import 'news_list_page.dart';
import 'news_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // LOAD TRƯỚC
  if (!NewsCache.loaded) {
    NewsCache.articles = await NewsService.fetchNews();
    NewsCache.loaded = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsListPage(),
    );
  }
}
