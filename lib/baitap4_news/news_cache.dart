import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/article.dart';

class NewsCache {
  static List<Article> articles = [];
  static bool loaded = false;

  static Future<void> loadNews() async {
    if (loaded) return;

    const apiKey = 'ad926baf66704c2597c6a27688799e9b';
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);

      articles = (data['articles'] as List)
          .where((e) =>
              e['url'] != null &&
              e['url'].toString().startsWith('http') &&
              e['urlToImage'] != null &&
              e['urlToImage'].toString().isNotEmpty)
          .map((e) => Article.fromJson(e))
          .toList();

      loaded = true;
    }
  }
}
