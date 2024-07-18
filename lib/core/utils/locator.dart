import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/data/data_source/firebase_auth_remote_data_source.dart';
import 'package:news_app/data/data_source/news_remote_data_source.dart';
import 'package:news_app/data/data_source/remote_config_data_source.dart';
import 'package:news_app/data/repository/auth_repository_impl.dart';
import 'package:news_app/data/repository/news_repository_impl.dart';
import 'package:news_app/data/repository/remote_config_repository_impl.dart';
import 'package:news_app/domain/repository/auth_repository.dart';
import 'package:news_app/domain/repository/config_repository.dart';
import 'package:news_app/domain/repository/news_repository.dart';
import 'package:news_app/domain/use_cases/get_country_code.dart';
import 'package:news_app/domain/use_cases/get_news.dart';
import 'package:news_app/domain/use_cases/save_name.dart';
import 'package:news_app/domain/use_cases/sign_in_with_email.dart';
import 'package:news_app/domain/use_cases/sign_up_with_email.dart';
import 'package:news_app/presentation/provider/firebase_provider.dart';

import '../../domain/use_cases/sign_out.dart';
import '../../presentation/provider/news_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory(() => NewsProvider(getNews: sl()));
  sl.registerFactory(() => FirebaseProvider(
        signInWithEmail: sl(),
        signUpWithEmail: sl(),
        signOut: sl(),
        saveName: sl(),
        getCountryCode: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetNews(sl()));
  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignUpWithEmail(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => SaveDetails(sl()));
  sl.registerLazySingleton(() => GetCountryCode(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ConfigRepository>(
    () => ConfigRepositoryImpl(remoteDataSource: sl()),
  );


  // Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(
    () => FirebaseAuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firebaseFirestore: sl(),
    ),
  );
  sl.registerLazySingleton<RemoteConfigDataSource>(
    () => FirebaseRemoteConfigDataSourceImpl(remoteConfig: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseRemoteConfig.instance);
}
