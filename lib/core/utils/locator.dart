import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/data/data_source/news_remote_data_source.dart';
import 'package:news_app/data/repository/news_repository_impl.dart';
import 'package:news_app/domain/repository/news_repository.dart';
import 'package:news_app/domain/use_cases/get_news.dart';

import '../../presentation/provider/news_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory(() => NewsProvider(getNews: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNews(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
