import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/domain/use_cases/save_name.dart';
import 'package:news_app/domain/use_cases/sign_in_with_email.dart';
import 'package:news_app/domain/use_cases/sign_out.dart';
import 'package:news_app/domain/use_cases/sign_up_with_email.dart';
import 'package:news_app/presentation/provider/news_provider.dart';
import 'package:news_app/presentation/screens/home/home_screen.dart';
import 'package:news_app/presentation/screens/signin/signin_screen.dart';
import 'package:provider/provider.dart';

class UserAuthProvider with ChangeNotifier {
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignOut signOut;
  final SaveDetails saveName;

  UserAuthProvider({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.saveName,
  });

  User? _user;
  User? get user => _user;

  String? _message;
  String? get message => _message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    _message = "";
    _isLoading = true;
    notifyListeners();

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

    final failureOrUser =
        await signUpWithEmail(SignUpParams(email: email, password: password));
    failureOrUser.fold(
      (failure) => _message = _mapFailureToMessage(failure),
      (user) => _user = user,
    );
    if (failureOrUser.isRight()) {
      _message = "";
      debugPrint('success @provider');
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

  navigateToHome(BuildContext context) {
    context.read<NewsProvider>().fetchNews();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  showErrorMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_message!),
      ),
    );
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
