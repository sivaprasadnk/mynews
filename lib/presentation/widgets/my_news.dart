import 'package:flutter/material.dart';
import 'package:my_news/core/utils/common_colors.dart';
import 'package:my_news/core/utils/common_strings.dart';
import 'package:my_news/core/utils/locator.dart' as di;
import 'package:my_news/presentation/provider/firebase_provider.dart';
import 'package:my_news/presentation/provider/news_provider.dart';
import 'package:my_news/presentation/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

class MyNewsApp extends StatelessWidget {
  const MyNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<NewsProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<FirebaseProvider>()),
      ],
      child: MaterialApp(
        title: kAppName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kBlueColor),
          appBarTheme: AppBarTheme(
            backgroundColor: kBlueColor,
          ),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: const SignUpScreen(),
      ),
    );
  }
}
