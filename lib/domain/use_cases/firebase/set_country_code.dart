import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/repository/realtime_db_repository.dart';

class SetCountryCode {
  final RealtimeDbRepository repository;

  SetCountryCode(this.repository);

  Future<Either<Failure, void>> call(String code) async {
    return await repository.setCountryCode(code);
  }
}
