import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/data/models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NewsModel>> getNews() async {
    final response = await client.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=8c37ef36eb7046068599b4c4d4309867'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['articles'] as List)
          .map((article) => NewsModel.fromJson(article))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
