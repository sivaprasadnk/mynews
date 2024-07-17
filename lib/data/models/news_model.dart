import 'package:news_app/domain/entity/news.dart';

class NewsModel extends News {
  const NewsModel({
    required super.title,
    required super.description,
    required super.imageUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      imageUrl: json['urlToImage'] ?? "",
    );
  }
}
