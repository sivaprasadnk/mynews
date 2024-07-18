import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class FirebaseRemoteConfigDataSource {
  Future<String> getCountryCode();
}

class FirebaseRemoteConfigDataSourceImpl
    implements FirebaseRemoteConfigDataSource {
  final FirebaseRemoteConfig remoteConfig;

  FirebaseRemoteConfigDataSourceImpl({required this.remoteConfig});

  @override
  Future<String> getCountryCode() async {
    await remoteConfig.fetchAndActivate();
    return remoteConfig.getString('country_code');
  }
}
