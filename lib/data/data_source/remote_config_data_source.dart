import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

abstract class RemoteConfigDataSource {
  Future<String> getCountryCode();
}

class FirebaseRemoteConfigDataSourceImpl implements RemoteConfigDataSource {
  final FirebaseRemoteConfig remoteConfig;

  FirebaseRemoteConfigDataSourceImpl({required this.remoteConfig});

  @override
  Future<String> getCountryCode() async {
    // var config = FirebaseRemoteConfig.instance;
    // var result = await config.fetchAndActivate();
    // debugPrint('result ::$result');
    var s = remoteConfig.getString('country_code');
    debugPrint('country_code ::$s');
    return s;
  }
}
