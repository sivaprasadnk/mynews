import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/repository/realtime_db_repository.dart';

class GetDetailsFromRealtimeDb {
  final RealtimeDbRepository repository;

  GetDetailsFromRealtimeDb(this.repository);

  Future<Either<Failure, Map>> call() async {
    return await repository.getDetails();
  }
}
