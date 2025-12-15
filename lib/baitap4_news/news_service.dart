import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/article.dart';

class NewsService {
  static const _apiKey = 'ad926baf66704c2597c6a27688799e9b';

  static Future<List<Article>> fetchNews() async {
    final url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey',
    );

    final res = await http.get(url);
    final data = jsonDecode(res.body);

    final List<Article> list = [];

    for (var item in data['articles']) {
      // CHỈ LẤY BÀI CÓ ẢNH + LINK
     if (item['url'] != null && item['url'].toString().startsWith('http')) {
  list.add(Article.fromJson(item));
}

    }

    return list;
  }
}
