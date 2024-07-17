import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/error/failures.dart';
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
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail(
      String email, String password) async {
    try {
      final user = await remoteDataSource.signUpWithEmail(email, password);
      return Right(user!);
    } on FirebaseAuthException {
      return Left(ServerFailure());
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
}
