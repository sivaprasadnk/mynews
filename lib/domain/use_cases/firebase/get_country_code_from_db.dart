import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/repository/realtime_db_repository.dart';

class GetCountryCodeFromDb {
  final RealtimeDbRepository repository;

  GetCountryCodeFromDb(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getCountryCode();
  }
}
