import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/data/models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews(String country);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NewsModel>> getNews(String country) async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=8c37ef36eb7046068599b4c4d4309867';
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    final jsonData = json.decode(response.body);
    return (jsonData['articles'] as List)
        .map((article) => NewsModel.fromJson(article))
        .toList();
  }
}
