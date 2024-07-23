import 'package:flutter/material.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/entity/news.dart';
import 'package:my_news/domain/use_cases/news/get_news.dart';

class NewsProvider with ChangeNotifier {
  final GetNews getNews;

  NewsProvider({required this.getNews});

  List<News>? _news;
  List<News>? get news => _news;

  String? _message;
  String? get message => _message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchNews(String country, String apiKey) async {
    _isLoading = true;
    notifyListeners();
    
    final failureOrNews = await getNews(country, apiKey);
    failureOrNews.fold(
      (failure) => _message = _mapFailureToMessage(failure),
      (news) => _news = news,
    );

    _isLoading = false;
    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.msg;
  }
}
