import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/core/utils/common_strings.dart';
import 'package:news_app/data/data_source/firebase_auth_remote_data_source.dart';
import 'package:news_app/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> signInWithEmail(
      String email, String password) async {
    try {
      final user = await remoteDataSource.signInWithEmail(email, password);
      return Right(user!);
    } on FirebaseAuthException catch (e) {
      debugPrint('e :${e.code}, mesg:${e.message}');
      return Left(
          SignUpFailure(message: _mapFirebaseAuthExceptionToMessage(e)));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail(
      String email, String password) async {
    try {
      final user = await remoteDataSource.signUpWithEmail(email, password);
      return Right(user!);
    } on FirebaseAuthException catch (e) {
      return Left(
          SignUpFailure(message: _mapFirebaseAuthExceptionToMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveDetails(User user, String name) async {
    try {
      await remoteDataSource.saveName(user, name);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  String _mapFirebaseAuthExceptionToMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      default:
        return kErrorMsg;
    }
  }
}
