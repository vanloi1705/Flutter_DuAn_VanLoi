class Article {
  final String title;
  final String description;
  final String imageUrl;
  final String content;
  final String url;

  Article({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
