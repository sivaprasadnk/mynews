import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/domain/repository/auth_repository.dart';

class SaveDetails {
  final AuthRepository repository;

  SaveDetails(this.repository);

  Future<Either<Failure, void>> call(User user, String name) async {
    return await repository.saveDetails(user, name);
  }
}
