import 'package:flutter/material.dart';
import 'package:news_app/core/utils/common_colors.dart';
import 'package:news_app/core/utils/common_strings.dart';
import 'package:news_app/core/utils/locator.dart' as di;
import 'package:news_app/presentation/provider/news_provider.dart';
import 'package:news_app/presentation/provider/user_auth_provider.dart';
import 'package:news_app/presentation/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

class MyNews extends StatelessWidget {
  const MyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<NewsProvider>()..getNews()),
        ChangeNotifierProvider(create: (_) => di.sl<UserAuthProvider>()),
      ],
      child: MaterialApp(
        title: kAppName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kBlueColor),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SignUpScreen(),
      ),
    );
  }
}
