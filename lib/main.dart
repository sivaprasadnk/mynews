import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:my_news/firebase_options.dart';
import 'package:my_news/presentation/widgets/my_news.dart';

import 'core/utils/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.sl<FirebaseRemoteConfig>().setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
  await di.sl<FirebaseRemoteConfig>().fetchAndActivate();

  runApp(const MyNewsApp());
}
