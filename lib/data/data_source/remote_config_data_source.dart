import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class RemoteConfigDataSource {
  Future<String> getCountryCode();
}

class FirebaseRemoteConfigDataSourceImpl implements RemoteConfigDataSource {
  final FirebaseRemoteConfig remoteConfig;

  FirebaseRemoteConfigDataSourceImpl({required this.remoteConfig});

  @override
  Future<String> getCountryCode() async {
    var s = remoteConfig.getString('country_code');
    return s;
  }
}
