import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/data/data_source/tts_data_source.dart';
import 'package:my_news/domain/repository/tts_repository.dart';

class TtsRepositoryImpl extends TtsRepository {
  final TtsDataSource dataSource;
  TtsRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, void>> speakText(String content) async {
    try {
      await dataSource.speakText(content);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> stopSpeaking() async {
    try {
      await dataSource.stop();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
