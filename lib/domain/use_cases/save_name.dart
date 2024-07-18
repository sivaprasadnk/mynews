import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/repository/auth_repository.dart';

class SaveDetails {
  final AuthRepository repository;

  SaveDetails(this.repository);

  Future<Either<Failure, void>> call(User user, String name) async {
    return await repository.saveDetails(user, name);
  }
}
