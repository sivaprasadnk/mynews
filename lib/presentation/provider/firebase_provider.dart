import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/domain/use_cases/get_country_code.dart';
import 'package:news_app/domain/use_cases/save_name.dart';
import 'package:news_app/domain/use_cases/sign_in_with_email.dart';
import 'package:news_app/domain/use_cases/sign_out.dart';
import 'package:news_app/domain/use_cases/sign_up_with_email.dart';
import 'package:news_app/presentation/provider/news_provider.dart';
import 'package:news_app/presentation/screens/home/home_screen.dart';
import 'package:news_app/presentation/screens/signin/signin_screen.dart';
import 'package:provider/provider.dart';

class FirebaseProvider with ChangeNotifier {
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignOut signOut;
  final SaveDetails saveName;
  final GetCountryCode getCountryCode;

  FirebaseProvider({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.saveName,
    required this.getCountryCode,
  });

  User? _user;
  User? get user => _user;

  String _countryCode = 'in';
  String get countryCode => _countryCode;

  String? _message;
  String? get message => _message;

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
    _isLoading = false;
    notifyListeners();
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

    _isLoading = false;
    notifyListeners();
  }

  navigateToHome(BuildContext context) async {
    final successOrFailure = await getCountryCode();
    successOrFailure.fold(
      (failure) => _countryCode = 'in',
      (data) => _countryCode = data,
    );
    debugPrint('country :: $countryCode');
    if (context.mounted) {
      if (countryCode.isEmpty) {
        _countryCode = 'in';
      }
      context.read<NewsProvider>().fetchNews(_countryCode);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
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
