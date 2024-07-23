import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/repository/realtime_db_repository.dart';

class GetApiKey {
  final RealtimeDbRepository repository;

  GetApiKey(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getCountryCode();
  }
}
