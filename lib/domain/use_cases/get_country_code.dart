import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/domain/repository/config_repository.dart';

class GetCountryCode {
  final ConfigRepository repository;

  GetCountryCode(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getCountryCode();
  }
}
