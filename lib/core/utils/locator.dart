import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_news/data/data_source/firebase_auth_remote_data_source.dart';
import 'package:my_news/data/data_source/news_remote_data_source.dart';
import 'package:my_news/data/data_source/realtime_db_data_source.dart';
import 'package:my_news/data/data_source/remote_config_data_source.dart';
import 'package:my_news/data/data_source/tts_data_source.dart';
import 'package:my_news/data/repository/auth_repository_impl.dart';
import 'package:my_news/data/repository/news_repository_impl.dart';
import 'package:my_news/data/repository/realtime_db_repository_impl.dart';
import 'package:my_news/data/repository/remote_config_repository_impl.dart';
import 'package:my_news/data/repository/tts_repository_impl.dart';
import 'package:my_news/domain/repository/auth_repository.dart';
import 'package:my_news/domain/repository/config_repository.dart';
import 'package:my_news/domain/repository/news_repository.dart';
import 'package:my_news/domain/repository/realtime_db_repository.dart';
import 'package:my_news/domain/repository/tts_repository.dart';
import 'package:my_news/domain/use_cases/firebase/get_api_key.dart';
import 'package:my_news/domain/use_cases/firebase/get_country_code_from_config.dart';
import 'package:my_news/domain/use_cases/firebase/get_country_code_from_db.dart';
import 'package:my_news/domain/use_cases/firebase/get_details_from_realtime_db.dart';
import 'package:my_news/domain/use_cases/firebase/save_name.dart';
import 'package:my_news/domain/use_cases/firebase/set_country_code.dart';
import 'package:my_news/domain/use_cases/firebase/sign_in_with_email.dart';
import 'package:my_news/domain/use_cases/firebase/sign_up_with_email.dart';
import 'package:my_news/domain/use_cases/news/get_news.dart';
import 'package:my_news/domain/use_cases/tts/speak_text.dart';
import 'package:my_news/presentation/provider/firebase_provider.dart';
import 'package:my_news/presentation/provider/tts_provider.dart';

import '../../domain/use_cases/firebase/sign_out.dart';
import '../../presentation/provider/news_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory(() => NewsProvider(getNews: sl()));
  sl.registerFactory(() => TtsProvider(speakText: sl()));
  sl.registerFactory(() => FirebaseProvider(
        signInWithEmail: sl(),
        signUpWithEmail: sl(),
        signOut: sl(),
        saveName: sl(),
        getCountryCodeFromConfig: sl(),
        getCountryCodeFromDb: sl(),
        setCountryCode: sl(),
        getApiKey: sl(),
        getDetails: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetNews(sl()));
  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignUpWithEmail(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => SaveDetails(sl()));
  sl.registerLazySingleton(() => GetCountryCodeFromConfig(sl()));
  sl.registerLazySingleton(() => GetCountryCodeFromDb(sl()));
  sl.registerLazySingleton(() => SetCountryCode(sl()));
  sl.registerLazySingleton(() => GetApiKey(sl()));
  sl.registerLazySingleton(() => GetDetailsFromRealtimeDb(sl()));
  sl.registerLazySingleton(() => SpeakText(sl()));

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
  sl.registerLazySingleton<RealtimeDbRepository>(
    () => RealtimeDbRepositoryImpl(datasource: sl()),
  );
  sl.registerLazySingleton<TtsRepository>(
    () => TtsRepositoryImpl(dataSource: sl()),
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
  sl.registerLazySingleton<RealtimeDatabaseDataSourceImpl>(
    () => RealtimeDatabaseDataSourceImpl(database: sl()),
  );
  sl.registerLazySingleton<TtsDataSource>(
    () => TtsDataSourceImpl(tts: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseRemoteConfig.instance);
  sl.registerLazySingleton(() => FirebaseDatabase.instance);
  sl.registerLazySingleton(() => FlutterTts());
}
