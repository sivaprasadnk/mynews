import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_news/data/models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews(String country, String apiKey);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NewsModel>> getNews(String country, String apiKey) async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey';
    debugPrint('url ::$url');    
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
