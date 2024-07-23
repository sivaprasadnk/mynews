import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/use_cases/firebase/get_api_key.dart';
import 'package:my_news/domain/use_cases/firebase/get_country_code_from_config.dart';
import 'package:my_news/domain/use_cases/firebase/get_country_code_from_db.dart';
import 'package:my_news/domain/use_cases/firebase/get_details_from_realtime_db.dart';
import 'package:my_news/domain/use_cases/firebase/save_name.dart';
import 'package:my_news/domain/use_cases/firebase/set_country_code.dart';
import 'package:my_news/domain/use_cases/firebase/sign_in_with_email.dart';
import 'package:my_news/domain/use_cases/firebase/sign_out.dart';
import 'package:my_news/domain/use_cases/firebase/sign_up_with_email.dart';
import 'package:my_news/presentation/provider/news_provider.dart';
import 'package:my_news/presentation/screens/home/home_screen.dart';
import 'package:my_news/presentation/screens/signin/signin_screen.dart';
import 'package:provider/provider.dart';

class FirebaseProvider with ChangeNotifier {
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignOut signOut;
  final SaveDetails saveName;
  final GetCountryCodeFromConfig getCountryCodeFromConfig;
  final GetCountryCodeFromDb getCountryCodeFromDb;
  final SetCountryCode setCountryCode;
  final GetApiKey getApiKey;
  final GetDetailsFromRealtimeDb getDetails;

  FirebaseProvider({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.saveName,
    required this.getCountryCodeFromConfig,
    required this.getCountryCodeFromDb,
    required this.setCountryCode,
    required this.getApiKey,
    required this.getDetails,
  });

  User? _user;
  User? get user => _user;

  String _countryCode = 'in';
  String get countryCode => _countryCode;

  String? _message;
  String? get message => _message;

  String? _apiKey;
  String? get apiKey => _apiKey;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    _message = "";
    _isLoading = true;
    notifyListeners();
    if (email.isEmpty) {
      _message = "Email cannot be empty!";
      showErrorMessage(context);
      return;
    }
    if (password.isEmpty) {
      _message = "Password cannot be empty!";
      showErrorMessage(context);
      return;
    }

    final failureOrUser =
        await signInWithEmail(SignInParams(email: email, password: password));
    failureOrUser.fold(
      (failure) => _message = _mapFailureToMessage(failure),
      (user) => _user = user,
    );
    if (failureOrUser.isRight() && context.mounted) {
      navigateToHome(context);
    } else {
      if (context.mounted) {
        showErrorMessage(context);
      }
    }
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    _message = "";
    _isLoading = true;
    notifyListeners();
    if (name.isEmpty) {
      _message = "Name cannot be empty!";
      showErrorMessage(context);
      return;
    }
    if (email.isEmpty) {
      _message = "Email cannot be empty!";
      showErrorMessage(context);
      return;
    }
    if (password.isEmpty) {
      _message = "Password cannot be empty!";
      showErrorMessage(context);
      return;
    }
    final failureOrUser =
        await signUpWithEmail(SignUpParams(email: email, password: password));
    failureOrUser.fold(
      (failure) => _message = _mapFailureToMessage(failure),
      (user) => _user = user,
    );
    if (failureOrUser.isRight()) {
      _message = "";
      final successOrFailure = await saveName(_user!, name);
      successOrFailure.fold(
        (failure) => _message = _mapFailureToMessage(failure),
        (_) {},
      );
      if (_message!.isEmpty && context.mounted) {
        navigateToHome(context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(context);
      }
    }
    // _isLoading = false;
    // notifyListeners();
  }

  navigateToHome(BuildContext context) async {
    final successOrFailure = await getDetails();
    successOrFailure.fold(
      (failure) {
        _message = failure.msg;
      },
      (data) {
        _countryCode = data['country_code'];
        _apiKey = data['api_key'];
      },
    );
    if (context.mounted) {
      if (countryCode.isEmpty) {
        _countryCode = 'in';
      }
      // await setCountryCode(_countryCode);
      if (context.mounted) {
        context.read<NewsProvider>().fetchNews(_countryCode, _apiKey!);
        _isLoading = false;
        notifyListeners();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    }
  }

  showErrorMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_message!),
      ),
    );
    _message = "";
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOutUser(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final failureOrVoid = await signOut();
    failureOrVoid.fold(
      (failure) => _message = _mapFailureToMessage(failure),
      (_) => _user = null,
    );
    if (failureOrVoid.isRight()) {
      if (context.mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const SignInScreen()));
      }
    } else {
      if (context.mounted) {
        showErrorMessage(context);
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.msg;
  }
}
