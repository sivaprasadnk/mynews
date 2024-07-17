import 'package:flutter/material.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/domain/entity/news.dart';
import 'package:news_app/domain/use_cases/get_news.dart';

class NewsProvider with ChangeNotifier {
  final GetNews getNews;

  NewsProvider({required this.getNews});

  List<News>? _news;
  List<News>? get news => _news;

  String? _message;
  String? get message => _message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    final failureOrNews = await getNews();
    failureOrNews.fold(
      (failure) => _message = _mapFailureToMessage(failure),
      (news) => _news = news,
    );

    _isLoading = false;
    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    // Handle different types of failures
    return 'Server Failure';
  }
}
