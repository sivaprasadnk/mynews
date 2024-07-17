import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/domain/use_cases/sign_in_with_email.dart';
import 'package:news_app/domain/use_cases/sign_out.dart';
import 'package:news_app/domain/use_cases/sign_up_with_email.dart';

class UserAuthProvider with ChangeNotifier {
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignOut signOut;

  UserAuthProvider({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
  });

  User? _user;
  User? get user => _user;

  String? _message;
  String? get message => _message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final failureOrUser =
        await signInWithEmail(SignInParams(email: email, password: password));
    _handleAuthResult(failureOrUser);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final failureOrUser =
        await signUpWithEmail(SignUpParams(email: email, password: password));
    _handleAuthResult(failureOrUser);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOutUser() async {
    _isLoading = true;
    notifyListeners();

    final failureOrVoid = await signOut();
    failureOrVoid.fold(
      (failure) => _message = _mapFailureToMessage(failure),
      (_) => _user = null,
    );

    _isLoading = false;
    notifyListeners();
  }

  void _handleAuthResult(Either<Failure, User> result) {
    result.fold(
      (failure) => _message = _mapFailureToMessage(failure),
      (user) => _user = user,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Handle different types of failures
    return 'Server Failure';
  }
}
